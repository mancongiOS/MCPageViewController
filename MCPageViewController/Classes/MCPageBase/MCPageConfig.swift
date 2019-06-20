//
//  MCPageConfig.swift
//  MCPageViewController
//
//  Created by MC on 2018/11/5.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit

public class MCPageConfig: NSObject {
    
    
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
     * 默认选中的分类下标
     * 默认第0页
     */
    public var defaultIndex : Int = 0


    public var category = CategoryStruct.init()

    public var indicator = IndicatorStruct.init()
    
    public var separator = SeparatorStruct.init()

    
    
    /// 清空自身
    public func empty() {
        
        viewControllers = []
        categoryModels = []
        category = CategoryStruct.init()
        indicator = IndicatorStruct.init()
        separator = SeparatorStruct.init()
    }
}




/// 对分类条的设置
public struct CategoryStruct {

    /// 分类名字最长显示字数
    public var maxTitleCount: Int = Int.max
    
    /// 未选中的字体颜色
    public var normalColor: UIColor = UIColor.MCPage_gray
    /// 选中的字体颜色
    public var selectedColor: UIColor = UIColor.MCPage_red
    
    /// 标题块的未选中字体大小
    public var normalFont : UIFont = UIFont.systemFont(ofSize: 15)
    /// 标题块的选中字体大小
    public var selectFont : UIFont = UIFont.boldSystemFont(ofSize: 16)
    
    
    /// 分类元素的宽度 （默认为0即根据文字长度自适应，如果设置大于0的值，就固定宽度）
    public var itemWidth: CGFloat = 0
    
    /// 给categoryItem额外加的宽度。 实际一个categoryItem的宽度 = 文字宽度 + categoryItemExtendWidth （仅在itemWidth<=0的时候有效）
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


/// 分割线的处理
public struct SeparatorStruct {
    
    public var backgroundColor = UIColor.lightGray
    public var height: CGFloat = 0.5
    /// 是否隐藏分割线
    public var isHidden: Bool = false
}




/// 对指示器的设置
public struct IndicatorStruct {
    
    /// 是否隐藏指示器
    public var isHidden = false
    /// 指示器的背景颜色
    public var backgroundColor = UIColor.red
    /// 指示器的高度
    public var height: CGFloat = 2
    /// 指示器的宽度 如果设置了width，Indicator的宽即为width.如果不设置即为自适应文字宽度
    public var width: CGFloat = 0

    /// 指示器的圆角
    public var cornerRadius: CGFloat = 1
}

