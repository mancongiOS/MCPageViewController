//
//  MCPageChildViewController.swift
//  FLAnimatedImage
//
//  Created by 满聪 on 2019/4/26.
//

import UIKit

public protocol MCPageChildViewControllerDelegate: NSObjectProtocol {
    func pageChildViewControllerLeaveTop(_ childViewController: MCPageChildViewController)
}

open class MCPageChildViewController: UIViewController {
    
    public weak var delegate: MCPageChildViewControllerDelegate?
    
    
    public var pageIndex: Int = 0
    
    
    private var canScroll: Bool = false
    
    private lazy var scrollView = UIScrollView()
    
    
    public func makePageViewControllerScroll(canScroll: Bool) {
        
        self.canScroll = canScroll;
        self.scrollView.showsVerticalScrollIndicator = canScroll;
        if (!canScroll) {
            self.scrollView.contentOffset = CGPoint.zero
        }
    }
    
    public func makePageViewControllerScrollToTop() {
        scrollView.contentOffset = CGPoint.zero
    }
    
    /// 子类重写该方法可以监听scrollViewDidScroll方法
    open func pageChildViewControllerScrollViewScroll(_ scrollView: UIScrollView) {
        
    }
    
}

extension MCPageChildViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        self.scrollView = scrollView
        
        pageChildViewControllerScrollViewScroll(scrollView)
        
        
        if (self.canScroll) {
            let offsetY = scrollView.contentOffset.y
            if (offsetY <= 0) {
                makePageViewControllerScroll(canScroll: false)
                delegate?.pageChildViewControllerLeaveTop(self)
            }
        } else {
            makePageViewControllerScroll(canScroll: false)
        }
    }
}





