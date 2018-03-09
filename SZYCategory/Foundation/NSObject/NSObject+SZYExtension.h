//
//  NSObject+SZYExtension.h
//  SZYCategory
//
//  Created by XiaoJin on 2018/3/8.
//  Copyright © 2018年 CharlesChwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SZYExtension)

@end

@interface NSObject (SZYThread)

- (void)szy_runInMainThread:(dispatch_block_t)block;
- (void)szy_runInMainThread:(dispatch_block_t)block delay:(double)second;

- (void)szy_runInGlobalQueue:(dispatch_block_t)block;
- (void)szy_runInGlobalQueue:(dispatch_block_t)block delay:(double)second;

@end
