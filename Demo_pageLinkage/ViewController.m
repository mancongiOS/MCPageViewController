//
//  ViewController.m
//  Demo_pageLinkage
//
//  Created by goulela on 2017/8/22.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "ViewController.h"

#import "PageViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"点击空白处";
    
    UINavigationBar * navigationBar = self.navigationController.navigationBar;
    navigationBar.translucent = NO;
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"Reuse_placeholder_2*1"] forBarMetrics:UIBarMetricsDefault];

}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    PageViewController * page = [[PageViewController alloc] init];
    [self.navigationController pushViewController:page animated:YES];
}

@end
