//
//  CALayer+SZYExtension.m
//  SZYCategory
//
//  Created by XiaoJin on 2018/3/8.
//  Copyright © 2018年 CharlesChwang. All rights reserved.
//

#import "CALayer+SZYExtension.h"

static inline void setLayerShadow(CALayer *layer, LayerShadow shadow){
    switch (shadow) {
        case LayerShadowNone: {
            layer.shadowOpacity = 0;
            layer.shadowRadius = 0;
            layer.shadowOffset = CGSizeZero;
            break;
        }
            // for top bar
        case LayerShadowDownLight: {
            layer.shadowOpacity = 0.2;
            layer.shadowRadius = 1;
            layer.shadowOffset = CGSizeMake(0, 1);
            break;
        }
        case LayerShadowDownNormal: {
            layer.shadowOpacity = 0.3;
            layer.shadowRadius = 1.2;
            layer.shadowOffset = CGSizeMake(0, 1.2);
            break;
        }
            // for raised view
        case LayerShadowDownFloat: {
            layer.shadowOpacity = 0.3;
            layer.shadowRadius = 5;
            layer.shadowOffset = CGSizeMake(0, 5);
            break;
        }
            // for bottom bar
        case LayerShadowUpLight: {
            layer.shadowOpacity = 0.08;
            layer.shadowRadius = 1;
            layer.shadowOffset = CGSizeMake(0, -1);
            break;
        }
        case LayerShadowUpNormal: {
            layer.shadowOpacity = 0.3;
            layer.shadowRadius = 1;
            layer.shadowOffset = CGSizeMake(0, -1);
            break;
        }
            // for center views
        case LayerShadowCenterLight: {
            layer.shadowOpacity = 0.3;
            layer.shadowRadius = 1.2;
            layer.shadowOffset = CGSizeZero;
            break;
        }
        case LayerShadowCenterNormal: {
            layer.shadowOpacity = 0.7;
            layer.shadowRadius = 1.2;
            layer.shadowOffset = CGSizeZero;
            break;
        }
        case LayerShadowCenterHeavy: {
            layer.shadowOpacity = 0.8;
            layer.shadowRadius = 1.5;
            layer.shadowOffset = CGSizeZero;
            break;
        }
    }
}

@implementation CALayer (SZYExtension)

- (void)szy_borderWidth:(CGFloat)width color:(UIColor *)color{
    self.borderColor = color.CGColor;
    self.borderWidth = width;
}

- (void)szy_maskToCircle{
    self.masksToBounds = YES;
    self.cornerRadius = 0.5 * fmin(self.frame.size.width, self.frame.size.height);
}

#pragma mark - shadow

- (void)szy_shadow:(LayerShadow)shadow{
    self.masksToBounds = NO;
    setLayerShadow(self, shadow);
}

- (void)szy_cornerRadius:(CGFloat)cornerRadius shadow:(LayerShadow)shadow{
    self.cornerRadius = cornerRadius;
    setLayerShadow(self, shadow);
}

- (void)szy_customShadowWithOpacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset{
    self.masksToBounds = NO;
    self.shadowOpacity = opacity;
    self.shadowRadius = radius;
    self.shadowOffset = offset;
}



@end
