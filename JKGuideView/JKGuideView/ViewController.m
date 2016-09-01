//
//  ViewController.m
//  JKGuideView
//
//  Created by lvjialin on 16/8/31.
//  Copyright © 2016年 lionnner. All rights reserved.
//

#import "ViewController.h"
#import "JKGuideView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    imageView.image = [UIImage imageNamed:@"girl"];
    
    [self.view addSubview:imageView];
    
    NSArray  *titles = @[@"新增: 功能1一大堆呀一大堆，字数不能太多了",
                         @"新增: 功能2一大堆呀一大堆，字数多的超屏了",
                         @"新增: 功能3一大堆，呀一大堆字数不能太多了",
                         @"新增: 功能4，一大堆呀一大堆字数不能太多了",
                         @"新增: 功能5，一大堆啊呀一大堆字数不能太多了",
                         ];

    CGRect frame1 = CGRectMake(220, 360, 80, 80);
    CGRect frame2 = CGRectMake(200, 60, 100, 80);
    CGRect frame3 = CGRectMake(0, 360, 120, 80);
    CGRect frame4 = CGRectMake(200, 360, 150, 80);
    CGRect frame5 = CGRectMake(220, 360, 80, 80);

    NSArray *frames = @[
                        NSStringFromCGRect(frame1),
                        NSStringFromCGRect(frame2),
                        NSStringFromCGRect(frame3),
                        NSStringFromCGRect(frame4),
                        NSStringFromCGRect(frame5),
                        ];
//    JKGuideView *guideView = [[JKGuideView alloc] initWithFrame:[UIScreen mainScreen].bounds titles:titles frames:frames];
    JKGuideView *guideView = [[JKGuideView alloc] initWithFrame:[UIScreen mainScreen].bounds titles:titles frames:frames alpha:0.5];
    [self.view addSubview:guideView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
