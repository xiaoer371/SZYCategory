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
            
            [objc_getClass("__NSArrayM") swizzleMethod:
             @selector(removeObjectAtIndex:) withMethod:@selector(szy_removeObjectAtIndex:) error:nil];
            
            [objc_getClass("__NSArrayM") swizzleMethod:
             @selector(insertObject:atIndex:) withMethod:@selector(szy_insertObject:atIndex:) error:nil];
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

- (void)szy_removeObjectAtIndex:(NSUInteger)index{
    if (self.count > index) {
          [self szy_removeObjectAtIndex:index];
    }
}

- (void)szy_insertObject:(id)anObject atIndex:(NSUInteger)index{
    if (anObject && index < self.count){
        [self szy_insertObject:anObject atIndex:index];
    }
}

@end

@implementation NSMutableArray(QueueOperation)

- (BOOL) isEmpty {
    return ([self count] <= 0);
}

- (void) pushBack:(id)object {
    [self addObject:object];
}

- (id) popBack {
    if (![self isEmpty]) {
        id object = [self lastObject];
        [self removeObject:object];
        return object;
    }
    return nil;
}

- (void) pushFront:(id)object{
    [self insertObject:object atIndex:0];
}

- (id) popFront {
    if (![self isEmpty]) {
        id object = [self firstObject];
        [self removeObjectAtIndex:0];
        return object;
    }
    return nil;
}





@end
