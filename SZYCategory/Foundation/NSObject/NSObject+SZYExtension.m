//
//  NSObject+SZYExtension.m
//  SZYCategory
//
//  Created by XiaoJin on 2018/3/8.
//  Copyright © 2018年 CharlesChwang. All rights reserved.
//

#import "NSObject+SZYExtension.h"

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
