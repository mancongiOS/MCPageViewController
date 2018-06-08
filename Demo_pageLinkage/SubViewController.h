//
//  SubViewController.h
//  Demo_pageLinkage
//
//  Created by goulela on 2017/8/22.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OneBlock)(NSString * string,UIViewController *vc);
typedef void(^TwoBlock)(int idnex);


@interface SubViewController : UIViewController

@property (nonatomic, copy) NSString * str;


@property (nonatomic, copy) OneBlock oneBlock;
@property (nonatomic, copy) TwoBlock twoBlock;


@end
