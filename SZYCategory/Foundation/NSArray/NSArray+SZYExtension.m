//
//  NSArray+SZYExtension.m
//  SZYCategory
//
//  Created by XiaoJin on 2018/3/8.
//  Copyright © 2018年 CharlesChwang. All rights reserved.
//

#import "NSArray+SZYExtension.h"
#import "NSObject+SZYExtension.h"

@implementation NSArray (SZYExtension)


@end

@implementation NSArray (Crash)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            [objc_getClass("__NSArrayI") swizzleMethod:
             @selector(objectAtIndex:) withMethod:@selector(szy_objectAtIndex:) error:nil];
        };
    });
}

- (id)szy_objectAtIndex:(NSUInteger)index{
    if (index < self.count) {
        return [self szy_objectAtIndex:index];
    }
    return nil;
}

@end

