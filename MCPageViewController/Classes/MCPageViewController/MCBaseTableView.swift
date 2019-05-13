//
//  MCBaseTableView.swift
//  MCPageViewController_Example
//
//  Created by 满聪 on 2019/4/26.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit




open class MCBaseTableView: UITableView, UIGestureRecognizerDelegate {

    
    public var categoryViewHeight: CGFloat = 0
    
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        
        return true

        
//        let segmentViewContentScrollViewHeight: CGFloat = UIDevice.height - UIDevice.topSafeAreaHeight - categoryViewHeight > 0 ? 0 : 40
//
//        let currentPoint: CGPoint = gestureRecognizer.location(in: self)
//
//
//        let contentRect = CGRect.init(x: 0, y: self.contentSize.height - segmentViewContentScrollViewHeight, width: UIDevice.width, height: segmentViewContentScrollViewHeight)
//
//        if contentRect.contains(currentPoint) {
//        }
//
//
//
//        return false
//
    }
    
}
