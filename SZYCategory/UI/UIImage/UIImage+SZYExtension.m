//
//  UIImage+SZYExtension.m
//  SZYCategory
//
//  Created by XiaoJin on 2018/3/8.
//  Copyright © 2018年 CharlesChwang. All rights reserved.
//

#import "UIImage+SZYExtension.h"
#import <ImageIO/ImageIO.h>

@implementation UIImage (SZYExtension)

+ (CGSize)szy_getImageSizeWithURL:(id)URL{
    NSURL * url = nil;
    if ([URL isKindOfClass:[NSURL class]]) {
        url = URL;
    }
    if ([URL isKindOfClass:[NSString class]]) {
        if ([(NSString *)URL length] > 0) {
            url = [NSURL URLWithString:URL];
        }else return CGSizeZero;
    }
    if (!URL) {
        return CGSizeZero;
    }
    CGImageSourceRef imageSourceRef = CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    CGFloat width = 0, height = 0;
    
    if (imageSourceRef) {
        // 获取图像属性
        CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, NULL);
        //手机32位、64位的处理
        if (imageProperties != NULL) {
            
            CFNumberRef widthNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
#if defined(__LP64__) && __LP64__
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat64Type, &width);
            }
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat64Type, &height);
            }
#else
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat32Type, &width);
            }
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat32Type, &height);
            }
#endif
            // 图像旋转的方向属性
            NSInteger orientation = [(__bridge NSNumber *)CFDictionaryGetValue(imageProperties, kCGImagePropertyOrientation) integerValue];
            CGFloat temp = 0;
            switch (orientation) {  // 如果图像的方向不是正的，则宽高互换
                case UIImageOrientationLeft: // 向左逆时针旋转90度
                case UIImageOrientationRight: // 向右顺时针旋转90度
                case UIImageOrientationLeftMirrored: // 在水平翻转之后向左逆时针旋转90度
                case UIImageOrientationRightMirrored: { // 在水平翻转之后向右顺时针旋转90度
                    temp = width;
                    width = height;
                    height = temp;
                }
                    break;
                default:
                    break;
            }
            CFRelease(imageProperties);
        }
        CFRelease(imageSourceRef);
    }
    return CGSizeMake(width, height);
}

- (UIImage *)szy_fixOrientation {
    
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


// 默认的压缩图片算法
+ (NSData *)compressWithMaxLength:(NSUInteger)legth imageData:(NSData *)imageData {
    
    if (!imageData) {return nil;}
    
    CGFloat maxLen = legth * 1024.0 * 1024.0;
    if (imageData.length < maxLen) return imageData;
    
    UIImage *oriImage = [UIImage imageWithData:imageData];
    CGFloat targetWH = 1280;
    CGFloat oriWidth = oriImage.size.width;
    CGFloat oriHeight = oriImage.size.height;
    
    if (targetWH > oriWidth && targetWH > oriHeight) {
        NSData *newData = [self compressImageWithOriImage:oriImage maxLength:maxLen];
        return newData;
    }
    
    // 宽高比
    CGFloat ratio = oriWidth/oriHeight;
    CGFloat targetH = 0.0;
    CGFloat targetW = 0.0;
    // 宽高 都大于1280
    if (targetWH < oriWidth && targetWH < oriHeight) {
        // 宽大于高 取较小值(高)等于1280，较大值等比例压缩
        if (ratio > 1) {
            targetH = targetWH;
            targetW = targetWH * ratio;
        }else{
            //高大于宽 取较小值(宽)等于1280，较大值等比例压缩
            targetW = targetWH;
            targetH = targetWH / ratio;
        }
        UIImage *image = [self imageCompressWithSourceimage:oriImage targetHeight:targetH targetWidth:targetW];
        NSData *newData = UIImageJPEGRepresentation(image, 1);
        if (newData.length > maxLen) {
            NSData *newData = [self compressImageWithOriImage:oriImage maxLength:maxLen];
            return newData;
        }
        return newData;
    }
    
    // 以下是图片其中一边大于1280的情况  这个阈值先暂时设置成2
    if (ratio > 2 ) {
        // 宽图片  比例大于2的情况  长宽不变，重绘。
        CGFloat minH = 100;
        targetW = targetWH * 2;
        targetH = targetW / ratio;
        //如果缩放过小 低于100
        if (targetH < minH) {
            targetW = minH * ratio;
            targetH = minH;
        }
    } else if (ratio < 0.5){
        //       长图片
        CGFloat minW = 100;
        targetH = targetWH * 2;
        targetW = targetW * ratio;
        //如果缩放过小 低于100
        if (targetW < minW) {
            targetW = minW;
            targetH = minW / ratio;
        }
    } else if (ratio > 1){
        //宽大于高 取较大值(宽)等于1280，较小值等比例压缩
        targetW = targetWH;
        targetH = targetWH / ratio;
    } else{
        // 高大于宽 取较大值(高)等于1280，较小值等比例压缩
        targetH = targetWH;
        targetW = targetWH * ratio;
    }
    UIImage *image = [self imageCompressWithSourceimage:oriImage targetHeight:targetH targetWidth:targetW];
    NSData *newData = UIImageJPEGRepresentation(image, 1);
    if (newData.length > maxLen) {
        NSData *newData = [self compressImageWithOriImage:oriImage maxLength:maxLen];
        return newData;
    }
    return newData;
}

+ (NSData *)compressImageWithOriImage:(UIImage *)oriImage maxLength:(NSUInteger)length{
    CGFloat compressionQuality = 1.0;
    NSData *newData = UIImageJPEGRepresentation(oriImage, compressionQuality);
    
    while (newData.length > length && compressionQuality >= 0.2) {
        compressionQuality -= 0.2;
        newData = UIImageJPEGRepresentation(oriImage, compressionQuality);
    }
    
    return newData;
}

+ (UIImage *)imageCompressWithSourceimage:(UIImage *)sourceImage
                             targetHeight:(CGFloat)targetHeight
                              targetWidth:(CGFloat)targetWidth
{
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0,0,targetWidth, targetHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)getAppLaunchImage {
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    NSString *viewOrientation = nil;
    if (([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown)
        || ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait)) {
        viewOrientation = @"Portrait";
    } else {
        viewOrientation = @"Landscape";
    }
    NSString *launchImage = nil;
    NSArray *imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary *dict in imagesDict){
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]){
            launchImage = dict[@"UILaunchImageName"];
            break;
        }
    }
    return [UIImage imageNamed:launchImage];
}

@end
