//
//  MCCategoryBarModel.swift
//  MCPageViewController_Example
//
//  Created by 满聪 on 2019/6/4.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

public class MCCategoryBarModel: NSObject {
    @objc public var title: String = "" {
        didSet {
            let config = MCPageConfig.shared
            title = title.MCClipFromPrefix(to: config.category.maxTitleCount)
        }
    }
        
    override public func setValue(_ value: Any?, forUndefinedKey key: String) { }
}


