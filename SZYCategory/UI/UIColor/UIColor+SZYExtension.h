//
//  UIColor+SZYExtension.h
//  SZYCategory
//
//  Created by XiaoJin on 2018/3/8.
//  Copyright © 2018年 CharlesChwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (SZYExtension)

// 取随机 颜色
+ (UIColor *)szy_randomColor;

/**
 16进制 初始化颜色

 @param hex 16进制
 @return 返回UIColor
 */
+ (UIColor *)szy_colorWithHex:(NSUInteger)hex;

+ (instancetype)szy_colorWithHexString:(NSString *)hexStr;


@end
