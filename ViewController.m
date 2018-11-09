//
//  ViewController.m
//  SZYCategory
//
//  Created by XiaoJin on 2018/3/8.
//  Copyright © 2018年 CharlesChwang. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+SZYExtension.h"
#import "CALayer+SZYExtension.h"
#import "UIImage+SZYExtension.h"
#import "NSArray+SZYExtension.h"

@interface ViewController ()

@property(strong, nonatomic)NSCondition *condition;
@property(strong, nonatomic)NSMutableArray *products;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.products = [[NSMutableArray alloc] init];
    self.condition = [[NSCondition alloc] init];

    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
