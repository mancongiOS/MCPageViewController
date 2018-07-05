//
//  MCPageViewController.h
//  Demo_pageViewController管理多页面
//
//  Created by goulela on 2017/8/17.
//  Copyright © 2017年 MC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MCPageViewController : UIViewController


// ============可选 设置属性


/** 标题栏的高度
 默认为40
 当设置 barHeight 为负数时候，隐藏标题栏。 实例：当有有且只有一个子页面的时候
 */
@property (nonatomic, assign) CGFloat   barHeight;

/**
 * 标题栏的背景颜色
 */
@property (nonatomic, strong) UIColor * barColor;


/**
 * 是否居左分布
 * 当所有的title的宽度累加小于屏幕宽度的时候，是靠左排布，还是所有的title均分屏幕的宽度
 */
@property (nonatomic, assign) BOOL   isLeftSideDistribution;

/**
 * 是否隐藏标题底部的滑块
 */
@property (nonatomic, assign) BOOL   isHiddenBlock;



/**
 titles              : 设置标题数组
 vcArray             : 设置控制器数组
 titleFont           : 标题块的字体的大小
 titleNormalColor    : 设置按钮文字未选中状态的颜色
 titleSelectedColor  : 设置按钮文字已选中状态的颜色
 currentPage         : 设置当前页
 */
- (void)initWithTitleArray:(NSArray *)titles vcArray:(NSArray *)vcArray titleFont:(CGFloat)titleFont titleNormalColor:(UIColor *)titleNormalColor titleSelectedColor:(UIColor *)titleSelectedColor currentPage:(NSInteger)currentPage;


// 跳转到固定页面下标的子页面
- (void)jumpToSubViewController:(NSInteger)index;



@end
