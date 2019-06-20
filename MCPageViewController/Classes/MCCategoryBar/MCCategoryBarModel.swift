//
//  MCCategoryBarModel.swift
//  MCPageViewController_Example
//
//  Created by 满聪 on 2019/6/4.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

public class MCCategoryBarModel: NSObject {
    
    
    
    @objc public var title: String = ""
    
    
    
    // ======================以下内部使用，请勿赋值====================== //
    
    /// 当前model的下标
    @objc public var index: Int = 0
    /// 是否选中
    @objc public var isSelected: Bool = false
    

    /// 最多显示几个字
    @objc public var maxTitleCount: Int = Int.max
    
    /// 未选中的字体颜色
    public var normalColor: UIColor = UIColor.MCPage_gray
    /// 选中的字体颜色
    public var selectedColor: UIColor = UIColor.MCPage_red
    
    /// 标题块的未选中字体大小
    public var normalFont : UIFont = UIFont.systemFont(ofSize: 15)
    /// 标题块的选中字体大小
    public var selectFont : UIFont = UIFont.boldSystemFont(ofSize: 16)
    
    
    /// 分类元素的宽度 （默认为0即根据文字长度自适应，如果设置大于0的值，就固定宽度）
    @objc public var itemWidth: CGFloat = 0
    /// 给categoryItem额外加的宽度。 实际一个categoryItem的宽度itemWidth = 文字宽度 + categoryItemExtendWidth （仅在itemWidth<=0的时候有效）
    public var itemExtendWidth: CGFloat = 0

    
    /// 标题块的背景颜色
    public var itemBackgroundColor : UIColor = UIColor.white
    

    override public func setValue(_ value: Any?, forUndefinedKey key: String) { }
}


