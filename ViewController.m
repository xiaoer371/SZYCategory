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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    aView.backgroundColor = [UIColor redColor];
    [aView.layer szy_customShadowWithOpacity:0.2 radius:0 offset:CGSizeMake(1, 150)];
    [self.view addSubview:aView];
    
    CGSize size =  [UIImage szy_getImageSizeWithURL:@""];
    NSLog(@"size ====== %@", NSStringFromCGSize(size));
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
