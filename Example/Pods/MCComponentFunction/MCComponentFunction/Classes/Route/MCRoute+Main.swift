//
//  MCRoute+Main.swift
//  MCAPI
//
//  Created by MC on 2018/11/26.
//

import Foundation
import UIKit

extension MCRoute {
    
    public func initRootController(subControllers:[UIViewController]) -> UITabBarController {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.lightGray
        configErrorController(view)
        tabBar = MCTabBarController(subControllers: subControllers)
        configRootController(tabBar!)
        return tabBar!
    }
    
    
    public static func setupItem(_ title: String,
                                 _ image: UIImage?,
                                 _ selectedImage: UIImage?,
                                 _ titleNormalColor: UIColor,
                                 _ titleSelectClor: UIColor) -> UITabBarItem
    {
        let item = UITabBarItem(title: title, image: image?.withRenderingMode(.alwaysOriginal), selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal))
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : titleNormalColor], for: .normal)
        item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : titleSelectClor], for: .selected)
        return item
    }
    
}

