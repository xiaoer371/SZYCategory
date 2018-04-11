//
//  NSObject+SZYExtension.m
//  SZYCategory
//
//  Created by XiaoJin on 2018/3/8.
//  Copyright © 2018年 CharlesChwang. All rights reserved.
//

#import "NSObject+SZYExtension.h"

#pragma mark 确保值的范围

inline NSNumber *SZYMakeNumberInRange(NSNumber *value, NSNumber *minValue, NSNumber *maxValue){
    value = @(MAX(value.doubleValue, minValue.doubleValue));
    value = @(MIN(value.doubleValue, maxValue.doubleValue));
    return value;
}

#pragma mark 判断值是否在范围内

inline BOOL SZYNumberContainedInRange(NSNumber *value, NSNumber *minValue, NSNumber *maxValue){
    return value.doubleValue >= minValue.doubleValue && value.doubleValue <= maxValue.doubleValue;
}


@implementation NSObject (SZYExtension)

@end

@implementation NSObject (SZYThread)

- (void)szy_runInMainThread:(dispatch_block_t)block {
    if (!block) return;
    if ([[NSThread currentThread] isMainThread]) {
        block();
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            block();
        });
    }
}

- (void)szy_runInMainThread:(dispatch_block_t)block delay:(double)second {
    if (!block) return;
    dispatch_time_t after = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC));
    dispatch_after(after, dispatch_get_main_queue(), block);
}

- (void)szy_runInGlobalQueue:(dispatch_block_t)block {
    if (!block) return;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

- (void)szy_runInGlobalQueue:(dispatch_block_t)block delay:(double)second {
    if (!block) return;
    dispatch_time_t after = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC));
    dispatch_after(after, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

@end

@implementation NSObject (Swizzle)

+ (BOOL)swizzleMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector error:(NSError **)error
{
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    if (!originalMethod) {
        NSString *string = [NSString stringWithFormat:@" %@ 类没有找到 %@ 方法",NSStringFromClass([self class]),NSStringFromSelector(originalSelector)];          *error = [NSError errorWithDomain:@"NSCocoaErrorDomain" code:-1 userInfo:[NSDictionary dictionaryWithObject:string forKey:NSLocalizedDescriptionKey]];   return NO;
    }
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
    
    if (!swizzledMethod) {
        NSString *string = [NSString stringWithFormat:@" %@ 类没有找到 %@ 方法",NSStringFromClass([self class]),NSStringFromSelector(swizzledSelector)];          *error = [NSError errorWithDomain:@"NSCocoaErrorDomain" code:-1 userInfo:[NSDictionary dictionaryWithObject:string forKey:NSLocalizedDescriptionKey]];   return NO;
    }
    
    if (class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod)))
    {
        class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    return YES;
}

@end


