//
//  PushViewController.m
//  Demo_pageLinkage
//
//  Created by goulela on 2017/8/22.
//  Copyright © 2017年 MC. All rights reserved.
//

#import "PushViewController.h"

@interface PushViewController ()

@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView * iv = [[UIImageView alloc] init];
    iv.image = [UIImage imageNamed:@"image"];
    iv.frame = CGRectMake(0, 0, 708/2.5, 824/2.5);
    iv.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
    [self.view addSubview:iv];
}
@end
