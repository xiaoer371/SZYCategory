//
//  NSMutableArray+SZYExtension.h
//  SZYCategory
//
//  Created by XiaoJin on 2018/4/11.
//  Copyright © 2018年 CharlesChwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (SZYExtension)

@end

@interface NSMutableArray (Crash)

@end

@interface NSMutableArray (QueueOperation)

-(BOOL) isEmpty;

// 先进先出
-(void) pushBack:(id)object;
-(id) popBack;

// 后进先出
-(void) pushFront:(id)object;
-(id) popFront;

@end
