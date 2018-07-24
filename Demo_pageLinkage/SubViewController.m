//
//  SubViewController.m
//  Demo_pageLinkage
//
//  Created by goulela on 2017/8/22.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "SubViewController.h"

#import "PushViewController.h"

#define kWidth self.view.bounds.size.width

@interface SubViewController ()

@end

@implementation SubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitle:@"跳转到热点分页" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = true;
    button.layer.borderColor = [UIColor redColor].CGColor;
    button.frame = CGRectMake(kWidth/2 - 60, 400, 120, 40);
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    
    
    
    UIButton * buttonOne = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonOne.titleLabel.font = [UIFont systemFontOfSize:14];
    [buttonOne setTitle:@"push到下个页面" forState:UIControlStateNormal];
    [buttonOne setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    buttonOne.layer.cornerRadius = 5;
    buttonOne.layer.masksToBounds = true;
    buttonOne.layer.borderColor = [UIColor redColor].CGColor;
    buttonOne.frame = CGRectMake(kWidth/2 - 60, 500, 120, 40);
    [buttonOne addTarget:self action:@selector(OnebuttonClicked) forControlEvents:UIControlEventTouchUpInside];
    buttonOne.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:buttonOne];

}


- (void)buttonClicked {
    
    // 2 是pageViewController的子页面的下标
    if (_twoBlock) {
        self.twoBlock(2);
    }
}

- (void)OnebuttonClicked {
    if (_oneBlock) {
        PushViewController * vc = [[PushViewController alloc] init];
        self.oneBlock(self.title, vc);
    }
}


- (void)setStr:(NSString *)str {
    UILabel * label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:19];
    label.text = [NSString stringWithFormat:@"页面标题: %@",str];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];

    label.frame = CGRectMake(self.view.bounds.size.width/2 - 100, 20, 200, 50);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_oneBlock) {
        PushViewController * two = [[PushViewController alloc] init];
        NSString * str = [NSString stringWithFormat:@"%@%@",self.title,@"页面"];
        self.oneBlock(str, two);
    }
}

@end
