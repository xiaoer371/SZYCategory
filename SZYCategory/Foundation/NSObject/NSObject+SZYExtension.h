//
//  NSObject+SZYExtension.h
//  SZYCategory
//
//  Created by XiaoJin on 2018/3/8.
//  Copyright © 2018年 CharlesChwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#pragma mark 确保值的范围

/**
 确保值在某个范围内
 
 @param value 初始值
 @param minValue 最小值
 @param maxValue 最大值
 @return 最终值
 */
CG_EXTERN NSNumber *SZYMakeNumberInRange(NSNumber *value, NSNumber *minValue, NSNumber *maxValue);

#pragma mark 判断值是否在范围内
/**
 值是否在某个范围内
 
 @param value 要判断的值
 @param minValue 最小值
 @param maxValue 最大值
 @return 是否在[最小值,最大值]范围内
 */
CG_EXTERN BOOL SZYNumberContainedInRange(NSNumber *value, NSNumber *minValue, NSNumber *maxValue);



@interface NSObject (SZYExtension)

@end

@interface NSObject (SZYThread)

- (void)szy_runInMainThread:(dispatch_block_t)block;
- (void)szy_runInMainThread:(dispatch_block_t)block delay:(double)second;

- (void)szy_runInGlobalQueue:(dispatch_block_t)block;
- (void)szy_runInGlobalQueue:(dispatch_block_t)block delay:(double)second;

@end

@interface NSObject (Swizzle)

+ (BOOL)swizzleMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector error:(NSError **)error;

@end

