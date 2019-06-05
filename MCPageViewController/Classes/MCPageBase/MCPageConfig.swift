//
//  MCPageConfig.swift
//  MCPageViewController
//
//  Created by MC on 2018/11/5.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit

public class MCPageConfig: NSObject {
    
    
    static public let shared: MCPageConfig = MCPageConfig.init()
    
    /**
     * 标题文字数据源
     * 数组个数必须和vcs个数一致
     */
    public var categoryModels: [MCCategoryBarModel] = [MCCategoryBarModel]()
    /**
     * 视图控制器数据源
     * 数组个数必须和titles个数一致
     */
    public var viewControllers: [UIViewController] = [UIViewController]()
    
    
    /**
     * 当前选中的分类下标
     * 默认第0页
     */
    public var selectIndex : Int = 0
    

    public var category = CategoryStruct.init()

    public var indicator = IndicatorStruct.init()
    
    
    /// 清空自身
    public func empty() {
        selectIndex = 0
        viewControllers = []
        categoryModels = []
        category = CategoryStruct.init()
        indicator = IndicatorStruct.init()
    }
}




/// 对分类条的设置
public struct CategoryStruct {

    /// 标题最长显示字数
    public var maxTitleCount: Int = 6
    
    /// 未选中的字体颜色
    public var normalColor: UIColor = UIColor.MCPage_gray
    /// 选中的字体颜色
    public var selectedColor: UIColor = UIColor.MCPage_red
    
    /// 标题块的未选中字体大小
    public var normalFont : UIFont = UIFont.systemFont(ofSize: 15)
    /// 标题块的选中字体大小
    public var selectFont : UIFont = UIFont.boldSystemFont(ofSize: 16)
    

    /**
     * 标题栏的高度， 内部计算使用
     */
    public var barHeight : CGFloat = 0
    
    /// 给categoryItem额外加的宽度。 实际一个categoryItem的宽度 = 文字宽度 + categoryItemExtendWidth
    public var itemExtendWidth: CGFloat = 10

    /// 标题栏的背景颜色
    public var barBackgroundColor : UIColor = UIColor.white
    /// 标题块的背景颜色
    public var itemBackgroundColor : UIColor = UIColor.white
    
    
    /// 分类之间的距离 （collectionView的minimumInteritemSpacing）
    public var itemSpacing: CGFloat = 0
    
    
    /// 分类的边距 （collectionView的sectionInset）
    public var  inset: (left: CGFloat, right: CGFloat) = (0, 0)
}





/// 对指示器的设置
public struct IndicatorStruct {
    
    /// 是否隐藏指示器
    public var isHiddenIndicator = false
    /// 指示器的背景颜色
    public var backgroundColor = UIColor.red
    /// 指示器的高度
    public var height: CGFloat = 2
    /// 指示器的宽度 如果设置了width，Indicator的宽即为width.如果不设置即为自适应文字宽度
    public var width: CGFloat = 0

    /// 指示器的圆角
    public var cornerRadius: CGFloat = 1
}

