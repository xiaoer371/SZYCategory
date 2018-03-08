//
//  UIAlertController+ZQ.h
//  ZQRunloopTest
//
//  Created by ZQQ on 2018/3/8.
//  Copyright © 2018年 zhangqq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController(ZQ)

/**
   批量添加action
 */
@property(nonatomic, strong) NSArray <UIAlertAction*>*actions;

/**
 标题颜色
 */
@property(nonatomic, strong) UIColor *titleColor;

/**
 内容颜色
 */
@property(nonatomic, strong) UIColor *messageColor;

/**
 标题字号
 */
@property(nonatomic, strong) UIFont* titleFont;

/**
 内容字号
 */
@property(nonatomic, strong) UIFont* messageFont;

/**
 显示aller在某个vc

 @param viewController vc
 @param dismiss 点击背景消失
 */
- (void)showInViewController:(UIViewController*)viewController canTapBackgroundDismiss:(BOOL)dismiss;


/**
 默认显示

 @param dismiss 是否点击背景消失
 */
- (void)showAlertCanTapBackgroundDismiss:(BOOL)dismiss;

@end
