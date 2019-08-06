//
//  MCNavigationController.swift
//  WisdomSpace
//
//  Created by goulela on 2017/8/29.
//  Copyright © 2017年 MC. All rights reserved.
//

import UIKit

public class MCNavigationController: UINavigationController, UIGestureRecognizerDelegate, UINavigationControllerDelegate {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        self.hidesBarsOnTap = false
        weak var weakSelf = self
        if responds(to: #selector(getter: interactivePopGestureRecognizer)) {
            interactivePopGestureRecognizer?.delegate = weakSelf
        }
        setup()
    }
    
    private func setup() {
        navigationBar.isTranslucent = false
    }
    
    override public func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        if navigationBar.isHidden {
            setNavigationBarHidden(false, animated: false)
        }
        
        if responds(to: #selector(getter: interactivePopGestureRecognizer)) {
            interactivePopGestureRecognizer?.isEnabled = false
        }
    }
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if navigationController.responds(to: #selector(getter: interactivePopGestureRecognizer)) {
            navigationController.interactivePopGestureRecognizer?.isEnabled = true
        }
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if children.count == 1 {
            return false
        }
        return true
    }
}








