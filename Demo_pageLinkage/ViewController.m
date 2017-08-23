//
//  ViewController.m
//  Demo_pageLinkage
//
//  Created by goulela on 2017/8/22.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "ViewController.h"

#import "PageViewController.h"
#import "SubViewController.h"

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
    
    
    NSMutableArray * vc = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray * title = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 15; i ++) {
        SubViewController * one = [[SubViewController alloc] init];
        
        one.str = [NSString stringWithFormat:@"第%d页",i];
        [vc addObject:one];
        
        __weak __typeof__(self) weakSelf = self;
        
        one.oneBlock = ^(NSString *string, UIViewController *vc) {
            
            vc.title = string;
            
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        
        
        [title addObject:[NSString stringWithFormat:@"第%d位",i]];
    }
    
    
    page.vcArray = vc;
    page.titleArray = title;    
    page.blockColor = [UIColor greenColor];
    page.blockWidth = 80;
    
    
    [self.navigationController pushViewController:page animated:YES];
}

@end
