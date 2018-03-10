//
//  NSString+SZYExtension.m
//  SZYCategory
//
//  Created by XiaoJin on 2018/3/8.
//  Copyright © 2018年 CharlesChwang. All rights reserved.
//

#import "NSString+SZYExtension.h"
#import "NSObject+SZYExtension.h"

@implementation NSString (SZYExtension)

inline NSString *NSStringFromBool(BOOL x){
    return @(x).stringValue;
}

inline NSString *NSStringFromFloat(float x){
    return @(x).stringValue;
}

inline NSString *NSStringFromCGFloat(CGFloat x){
    return @(x).stringValue;
}

inline NSString *NSStringFromInt(int x){
    return @(x).stringValue;
}

inline NSString *NSStringFromNSInteger(NSInteger x){
    return @(x).stringValue;
}

inline NSString *NSStringFromNSUInteger(NSUInteger x){
    return @(x).stringValue;
}



inline NSString *NSStringFromPointer(id x){
    return [NSString stringWithFormat:@"%p",x];
}

inline NSString *NSStringFromPercent(CGFloat x){
    x = SZYMakeNumberInRange(@(x), @0, @1).doubleValue;
    return [NSString stringWithFormat:@"%@%%",@(100 * x)];
}


- (UIImage *)image{
    return [UIImage imageNamed:self];
}


#pragma mark - URLEncoding URLDecoding 
- (NSString *)szy_URLEncoding{
    NSString * result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault,
                                                                                              (CFStringRef)self,
                                                                                              NULL,
                                                                                              CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                                              kCFStringEncodingUTF8 ));
    return result;
}

- (NSString *)szy_URLDecoding{
    NSMutableString * string = [NSMutableString stringWithString:self];
    [string replaceOccurrencesOfString:@"+"
                            withString:@" "
                               options:NSLiteralSearch
                                 range:NSMakeRange(0, [string length])];
    return [string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
