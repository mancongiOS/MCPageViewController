//
//  PageViewController.m
//  Demo_pageLinkage
//
//  Created by goulela on 2017/8/22.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "PageViewController.h"

#import "SubViewController.h"


@interface PageViewController ()

@end

@implementation PageViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"页面联动";
    
    
    NSMutableArray * vc = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray * title = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < 15; i ++) {
        SubViewController * one = [[SubViewController alloc] init];
        
        one.str = [NSString stringWithFormat:@"第%d页",i];
        [vc addObject:one];
        
        // 子页面上点击事件的处理
        __weak __typeof__(self) weakSelf = self;
        one.oneBlock = ^(NSString *string, UIViewController *vc) {
            vc.title = string;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        
        [title addObject:[NSString stringWithFormat:@"第%d位",i]];
    }
    
    self.blockFont = 40;
    self.barHeight = 100;
    self.blockColor = [UIColor yellowColor];
    
    [self initWithTitleArray:title vcArray:vc blockNormalColor:[UIColor lightGrayColor] blockSelectedColor:[UIColor redColor] currentPage:0];
}

@end
