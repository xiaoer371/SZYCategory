//
//  UIAlertController+ZQ.m
//  ZQRunloopTest
//
//  Created by ZQQ on 2018/3/8.
//  Copyright © 2018年 zhangqq. All rights reserved.
//

#import "UIAlertController+ZQ.h"
#import <objc/runtime.h>

static NSString* const kActionsKey = @"actionsKey";
static NSString* const kTitleColorKey = @"titleColorKey";
static NSString* const kMessageColorKey = @"messageColorKey";
static NSString* const kTitleFontKey = @"titleFontKey";
static NSString* const kMessageFontKey = @"messageFontKey";


@interface UIAlertController()

@end

@implementation UIAlertController(ZQ)

- (void)setActions:(NSArray<UIAlertAction *> *)actions {
    for (UIAlertAction *action in actions) {
        [self addAction:action];
    }
    objc_setAssociatedObject(self, &kActionsKey, actions, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray<UIAlertAction*>*)actions {
    return objc_getAssociatedObject(self, &kActionsKey);
}

- (void)setTitleColor:(UIColor *)titleColor {
    objc_setAssociatedObject(self, &kTitleColorKey, titleColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self configTitle];
}
- (UIColor*)titleColor {
    return objc_getAssociatedObject(self, &kTitleColorKey);
}

- (void)setTitleFont:(UIFont *)titleFont {
    objc_setAssociatedObject(self, &kTitleFontKey, titleFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self configTitle];
}

- (UIFont*)titleFont {
    return objc_getAssociatedObject(self, &kTitleFontKey);
}

- (void)setMessageColor:(UIColor *)messageColor {
    objc_setAssociatedObject(self, &kMessageColorKey, messageColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self configMessage];
}

- (UIColor*)messageColor {
   return objc_getAssociatedObject(self, &kMessageColorKey);
}

- (void)setMessageFont:(UIFont *)messageFont {
    objc_setAssociatedObject(self, &kMessageFontKey, messageFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self configMessage];
}

- (UIFont*)messageFont {
   return objc_getAssociatedObject(self, &kMessageFontKey);
}

- (void)configTitle {
    
    if (self.title && self.title.length > 0) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self.title];
        NSMutableDictionary *attributeds = [NSMutableDictionary new];
        if (self.titleFont) {
            [attributeds setObject:self.titleFont forKey:NSFontAttributeName];
        }
        if (self.titleColor) {
            [attributeds setObject:self.titleColor forKey:NSForegroundColorAttributeName];
        }
        [attributedString setAttributes:attributeds range:NSMakeRange(0, self.title.length)];
        [self setValue:attributedString forKey:@"attributedTitle"];
    }
}

- (void)configMessage {
    if (self.message && self.message.length > 0) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self.message];
        NSMutableDictionary *attributeds = [NSMutableDictionary new];
        if (self.messageFont) {
            [attributeds setObject:self.messageFont forKey:NSFontAttributeName];
        }
        if (self.messageColor) {
            [attributeds setObject:self.messageColor forKey:NSForegroundColorAttributeName];
        }
        [attributedString setAttributes:attributeds range:NSMakeRange(0, self.message.length)];
        [self setValue:attributedString forKey:@"attributedMessage"];
    }
}

#pragma mark - show

- (void)showAlertCanTapBackgroundDismiss:(BOOL)dismiss {
    UIViewController *vc = [UIApplication sharedApplication].delegate.window.rootViewController;
    [self showInViewController:vc canTapBackgroundDismiss:dismiss];
}

- (void)showInViewController:(UIViewController *)viewController canTapBackgroundDismiss:(BOOL)dismiss {
    
    [viewController presentViewController:self animated:YES completion:^{
        if (dismiss) {
            CGRect rect = [UIScreen mainScreen].bounds;
            UIControl *bGView = [[UIControl alloc] init];
            bGView.backgroundColor = [UIColor clearColor];
            bGView.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
            [bGView addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
            [self.view.superview insertSubview:bGView atIndex:self.view.superview.subviews.count - 1];
        }
    }];
}

- (void)dismiss:(UIControl*)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [sender removeFromSuperview];
    }];
}
@end
