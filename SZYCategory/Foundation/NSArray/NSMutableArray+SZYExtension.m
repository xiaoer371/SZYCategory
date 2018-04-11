//
//  NSMutableArray+SZYExtension.m
//  SZYCategory
//
//  Created by XiaoJin on 2018/4/11.
//  Copyright © 2018年 CharlesChwang. All rights reserved.
//

#import "NSMutableArray+SZYExtension.h"
#import "NSObject+SZYExtension.h"

@implementation NSMutableArray (SZYExtension)

@end

@implementation NSMutableArray (Crash)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            [objc_getClass("__NSArrayM") swizzleMethod:
             @selector(addObject:) withMethod:@selector(szy_addObject:) error:nil];
            [objc_getClass("__NSArrayM") swizzleMethod:
             @selector(removeObject:) withMethod:@selector(szy_removeObject:) error:nil];
        };
    });
}

- (void)szy_addObject:(id)object{
    if (object) {
        [self szy_addObject:object];
    }
}

- (void)szy_removeObject:(id)object{
    if (object) {
        [self szy_removeObject:object];
    }
}

@end
