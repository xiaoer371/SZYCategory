//
//  CALayer+SZYExtension.h
//  SZYCategory
//
//  Created by XiaoJin on 2018/3/8.
//  Copyright © 2018年 CharlesChwang. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LayerShadowNone,           // 清除阴影
    LayerShadowDownLight,      // 适用于浅色NavigationBar
    LayerShadowDownNormal,     // 适用于深色NavigationBar
    LayerShadowDownFloat,      // 适用于浮起的按钮
    LayerShadowUpLight,        // 适用于浅色的TabBar
    LayerShadowUpNormal,       // 适用于深色的TabBar
    LayerShadowCenterLight,    // 适用于浅色的按钮、图片等控件
    LayerShadowCenterNormal,   // 适用于普通的按钮、图片等控件
    LayerShadowCenterHeavy,    // 适用于深色的按钮、图片等控件
} LayerShadow;

@interface CALayer (SZYExtension)

// 设置 边框颜色
- (void)szy_borderWidth:(CGFloat)width color:(UIColor *)color;

// 设置 圆形头像 （ps：不要在多数据源中 cell 使用）
- (void)szy_maskToCircle;

//设置阴影
- (void)szy_shadow:(LayerShadow)shadow;

- (void)szy_cornerRadius:(CGFloat)cornerRadius shadow:(LayerShadow)shadow;

- (void)szy_customShadowWithOpacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset;

@end
