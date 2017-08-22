//
//  SubViewController.h
//  Demo_pageLinkage
//
//  Created by goulela on 2017/8/22.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OneBlock)(NSString * string,UIViewController *vc);


@interface SubViewController : UIViewController

@property (nonatomic, copy) NSString * str;


@property (nonatomic, copy) OneBlock oneBlock;


@end
