//
//  MCTabBarController.swift
//  WisdomSpace
//
//  Created by goulela on 2017/8/29.
//  Copyright © 2017年 MC. All rights reserved.
//

import UIKit

public class MCTabBarController: UITabBarController,UITabBarControllerDelegate {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = UIColor.white
        tabBar.isTranslucent = false
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    init(subControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        viewControllers = subControllers
        delegate = self
        selectedIndex = 0
        tabBar.barTintColor = UIColor.white
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

