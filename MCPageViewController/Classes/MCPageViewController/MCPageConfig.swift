//
//  MCPageConfig.swift
//  MCPageViewController
//
//  Created by MC on 2018/11/5.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit

public class MCPageConfig: NSObject {
    
    
    static public let shared = MCPageConfig.init()
    
    // titles，vcs 必填    
    /**
     * 标题文字数据源
     * 数组个数必须和vcs个数一致
     */
    public var categoryModels: [MCCategoryModel] = [MCCategoryModel]()
    /**
     * 视图控制器数据源
     * 数组个数必须和titles个数一致
     */
    public var viewControllers: [UIViewController] = [UIViewController]()

    /**
     * 默认的颜色
     */
    public var normalColor: UIColor = UIColor.MCPage_gray
    
    /**
     * 选中的颜色
     */
    public var selectedColor: UIColor = UIColor.MCPage_red

    
    /**
     * 滑块颜色
     */
    public var indicatorColor : UIColor = UIColor.MCPage_red

    /**
     * 是否隐藏指示线
     * indicatorView
     */
    public var isHiddenIndicator : Bool = false
    
    
    /// 标题最长字数
    public var maxTitleCount: Int = 5
    
    /**
     * 标题栏的高度
     * 默认值40
     * 如何设置的高度为0~20，修复为20
     * 如何设置的高度为负数，则隐藏标题栏。实例：当有有且只有一个子页面的时候，要隐藏的时候
     */
    public var barHeight : CGFloat = 40 {
        didSet {
            if (barHeight <= 0) { barHeight = 0 }
            if (barHeight > 0 && barHeight < 20 ) { barHeight = 40 }
        }
    }
    
    /**
     * 标题块的默认字体
     * 默认15
     */
    public var normalFont : UIFont = UIFont.systemFont(ofSize: 15)
    
    /**
     * 标题块选中字体
     * 默认16
     */

    public var selectFont : UIFont = UIFont.boldSystemFont(ofSize: 16)

    
    /**
     * 标题块的背景颜色
     * 默认为白色
     */
    public var categoryBackgroundColor : UIColor = UIColor.white
    
    
    
    /// 分类元素的间距 （collectionView的minimumInteritemSpacing）
    public var categoryItemSpacing: CGFloat = 1
    
    
    /// 分类的边距 （collectionView的sectionInset）
    public var  categoryInset: UIEdgeInsets = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)

    
    /// 背景颜色
    public var barBackgroundColor : UIColor = UIColor.white

    /**
     * 当前选中的分类下标
     * 默认第0页
     */
    public var selectIndex : Int = 0
    
    
    /**
     * 是否展示右侧更多按钮
     * 默认不显示
     */
    public var isShowMoreButton: Bool = false
    
    /// 更多按钮图片
    public var moreImage: UIImage? = UIImage.init()
}
