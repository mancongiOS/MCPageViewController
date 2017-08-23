//
//  MCPageViewController.h
//  Demo_pageViewController管理多页面
//
//  Created by goulela on 2017/8/17.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MCPageViewController : UIViewController

@property (nonatomic, strong) NSArray * titleArray;           // 存放标题的数组
@property (nonatomic, strong) NSArray * vcArray;              // 控制器的数组

@property (nonatomic, strong) UIColor * barColor;             // 标题栏的背景颜色
@property (nonatomic, assign) CGFloat   barHeight;            // 标题栏的高度  默认我40

@property (nonatomic, assign) CGFloat   blockWidth;           // 标题块的宽度  默认50
@property (nonatomic, assign) CGFloat   blockFont;            // 标题块的字体的大小  默认18
@property (nonatomic, strong) UIColor * blockColor;           // 标题块的背景颜色
@property (nonatomic, strong) UIColor * blockNormalColor;     // 标题块的默认颜色
@property (nonatomic, strong) UIColor * blockSelectedColor;   // 标题块的选择颜色


@property (nonatomic, assign) NSInteger currentPage;          // 需要显示的页面  默认为第零页

// 实现自身的方法. 必须调用
- (void)achieve;

@end
