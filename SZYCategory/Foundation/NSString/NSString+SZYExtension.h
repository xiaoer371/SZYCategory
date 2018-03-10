//
//  NSString+SZYExtension.h
//  SZYCategory
//
//  Created by XiaoJin on 2018/3/8.
//  Copyright © 2018年 CharlesChwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (SZYExtension)

/**
 BOOL转字符串(0/1)
 
 @param x BOOL类型
 @return 字符串
 */
FOUNDATION_EXTERN NSString *NSStringFromBool(BOOL x);

/**
 CGFloat转字符串
 
 @param x CGFloat
 @return 字符串
 */
FOUNDATION_EXTERN NSString *NSStringFromFloat(float x);

/**
 CGFloat转字符串
 
 @param x CGFloat
 @return 字符串
 */
FOUNDATION_EXTERN NSString *NSStringFromCGFloat(CGFloat x);


/**
 int转字符串
 
 @param x int
 @return 字符串
 */
FOUNDATION_EXTERN NSString *NSStringFromInt(int x);

/**
 NSInteger转字符串
 
 @param x NSInteger
 @return 字符串
 */
FOUNDATION_EXTERN NSString *NSStringFromNSInteger(NSInteger x);

/**
 NSUInteger转字符串
 
 @param x NSUInteger
 @return 字符串
 */
FOUNDATION_EXTERN NSString *NSStringFromNSUInteger(NSUInteger x);



/**
 输出指针地址
 
 @param x id指针
 @return id指针的地址
 */
CG_EXTERN NSString *NSStringFromPointer(id x);

/**
 输出百分比
 
 @param x 0~1
 @return 0% ~ 100%
 */
FOUNDATION_EXTERN NSString *NSStringFromPercent(CGFloat x);


- (NSString *)szy_URLEncoding;
- (NSString *)szy_URLDecoding;

//====
- (UIImage *)image;

@end
