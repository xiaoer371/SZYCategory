//
//  UIImage+SZYExtension.h
//  SZYCategory
//
//  Created by XiaoJin on 2018/3/8.
//  Copyright © 2018年 CharlesChwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SZYExtension)

// 根据URL 获取图面尺寸 NSURL 或者 NSString 
+ (CGSize)szy_getImageSizeWithURL:(id)URL;

// 修正图片尺寸
- (UIImage *)szy_fixOrientation;

@end
