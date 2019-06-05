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
        
        
        let height = (self.tableFooterView?.frame.size.height ?? 0) - MCPageConfig.shared.category.barHeight
        
        let segmentViewContentScrollViewHeight: CGFloat = height > 0 ? height : MCPageConfig.shared.category.barHeight
        
        let contentRect = CGRect.init(x: 0, y: self.contentSize.height - segmentViewContentScrollViewHeight, width: UIDevice.width, height: segmentViewContentScrollViewHeight)
        
        if contentRect.contains(currentPoint) {
            return true
        }
        return false
    }
}



extension UIDevice {
    
    
    ///屏幕宽
    fileprivate static let width: CGFloat    = UIScreen.main.bounds.size.width
    
    ///屏幕高
    fileprivate static let height: CGFloat   = UIScreen.main.bounds.size.height
    
}

