//
//  MCPageConfig.swift
//  MCPageViewController
//
//  Created by MC on 2018/11/5.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit

public class MCPageConfig: NSObject {
    
    // titles，vcs 必填    
    /**
     * 标题文字数据源
     * 数组个数必须和vcs个数一致
     */
    @objc var titles : [String] = [String]()
    /**
     * 视图控制器数据源
     * 数组个数必须和titles个数一致
     */
    @objc var vcs : [UIViewController] = [UIViewController]()

    /**
     * 默认的颜色
     */
    @objc var normalColor : UIColor = UIColor.MCPage_gray
    
    /**
     * 选中的颜色
     */
    @objc var selectedColor : UIColor = UIColor.MCPage_red

    
    /**
     * 标题块的宽度
     * 默认为0
     * 如果标题块的宽度为0，则根据文字的长度自动计算标题块的宽度，否则就用设置的。
     */
    @objc var blockWidth : CGFloat = 0

    
    /**
     * 是否隐藏指示线
     * indicatorView
     */
    @objc var isHiddenIndicator : Bool = false
    
    
    /**
     * 标题栏的高度
     * 默认值40
     * 如何设置的高度为0~20，修复为20
     * 如何设置的高度为负数，则隐藏标题栏。实例：当有有且只有一个子页面的时候，要隐藏的时候
     */
    @objc var barHeight : CGFloat = 40 {
        didSet {
            if (barHeight <= 0) { barHeight = 0 }
            if (barHeight > 0 && barHeight < 20 ) { barHeight = 40 }
        }
    }
    
    /**
     * 标题块的字体的大小
     * 默认15
     */
    @objc var blockFont : CGFloat = 15 {
        didSet {
            if (blockFont < 10) { blockFont = 15 }
        }
    }
    
    
    
    /**
     * 标题块的背景颜色
     * 默认为白色
     */
    @objc var blockColor : UIColor = UIColor.white
    
    
    /**
     * 当title数量少的时候，是否居左
     * 默认居中
     */
    @objc var isLeftPosition : Bool = false
    
    /**
     * 第一次打开，默认显示第几页
     * 默认第0页
     */
    @objc var defaultIndex : Int = 0
}
