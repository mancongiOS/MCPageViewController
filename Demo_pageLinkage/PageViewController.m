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
    
    
    NSArray * dataArray = @[@"关注",@"推荐",@"热点",@"上海",@"娱乐",@"头条",@"问答",@"科技",@"视频",@"关注",@"推荐",@"热点",@"上海",@"娱乐",@"头条",@"问答",@"科技",@"视频"];
  
    
    //    NSArray * dataArray = @[@"关注",@"推荐"];
    //    self.barHeight = 40;
    //    self.isLeftSideDistribution = true;
    //    self.isHiddenBlock = true;
    
    
    NSMutableArray * vcArrayM = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < dataArray.count; i ++) {
        SubViewController * one = [[SubViewController alloc] init];
        one.title = dataArray[i];
        one.str = dataArray[i];
        [vcArrayM addObject:one];
        
        // 子页面上点击事件的处理  --> push到下个页面
        __weak __typeof__(self) weakSelf = self;
        one.oneBlock = ^(NSString *string, UIViewController *vc) {
            vc.title = string;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        
        // 子页面上点击事件的处理  --> 跳转到其他pageViewController的子页面
        one.twoBlock = ^(int index) {
            [weakSelf jumpToSubViewController:index];
        };
        
    }

    [self initWithTitleArray:dataArray vcArray:vcArrayM blockNormalColor:[UIColor lightGrayColor] blockSelectedColor:[UIColor redColor]];
    
    
    [self jumpToSubViewController:2];
}

@end
