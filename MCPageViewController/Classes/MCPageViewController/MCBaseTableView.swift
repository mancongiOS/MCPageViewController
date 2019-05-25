//
//  MCBaseTableView.swift
//  MCPageViewController_Example
//
//  Created by 满聪 on 2019/4/26.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit




open class MCBaseTableView: UITableView, UIGestureRecognizerDelegate {

    
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        

        let currentPoint: CGPoint = gestureRecognizer.location(in: self)


        let height = (self.tableFooterView?.frame.size.height ?? 0) - MCPageConfig.shared.barHeight
        
        let segmentViewContentScrollViewHeight: CGFloat = height > 0 ? height : MCPageConfig.shared.barHeight


        let contentRect = CGRect.init(x: 0, y: self.contentSize.height - segmentViewContentScrollViewHeight, width: UIDevice.width, height: segmentViewContentScrollViewHeight)

        if contentRect.contains(currentPoint) {
            return true
        }
        return false
    }
}



extension UIDevice {
    
    
    ///屏幕宽
    public static let width: CGFloat    = UIScreen.main.bounds.size.width
    
    ///屏幕高
    public static let height: CGFloat   = UIScreen.main.bounds.size.height
    
    ///状态栏高度
    public static let statusBarHeight: CGFloat   = UIApplication.shared.statusBarFrame.height
    
    /// tabbar的高度
    public static let tabBarHeight: CGFloat   = 49 + bottomSafeAreaHeight
    
    ///导航栏高度
    public static let navigationBarHeight: CGFloat = 44 + statusBarHeight
    
    /// 顶部安全区域的高度 (20 or 44)
    public static let topSafeAreaHeight: CGFloat   = UIDevice.safeAreaInsets().top
    
    /// 底部安全区域 (0 or 34)
    public static let bottomSafeAreaHeight: CGFloat  = UIDevice.safeAreaInsets().bottom
    
    
    private static func safeAreaInsets() -> (top: CGFloat, bottom: CGFloat) {
        if #available(iOS 11.0, *) {
            
            let inset = UIApplication.shared.delegate?.window??.safeAreaInsets
            
            return (inset?.top ?? 0, inset?.bottom ?? 0)
        } else {
            return (0, 0)
        }
    }
    
}
