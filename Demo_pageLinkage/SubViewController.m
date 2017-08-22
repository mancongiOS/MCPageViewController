//
//  SubViewController.m
//  Demo_pageLinkage
//
//  Created by goulela on 2017/8/22.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "SubViewController.h"

#import "PushViewController.h"

@interface SubViewController ()

@end

@implementation SubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
}


- (void)setStr:(NSString *)str {
    UILabel * label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:40];
    label.text = str;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    label.backgroundColor = [UIColor orangeColor];

    label.bounds = CGRectMake(0, 0, 150, 150);
    label.center = self.view.center;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_oneBlock) {
        PushViewController * two = [[PushViewController alloc] init];
        self.oneBlock(@"跳转到的页面", two);
    }
}

@end
