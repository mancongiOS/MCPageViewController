//
//  MCContainerView.swift
//  MCPageViewController_Example
//
//  Created by 满聪 on 2019/6/4.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

import SnapKit

@objc public protocol MCContainerViewDelegate {
    
    /// 滑动到对应控制器
    func containerView(_ containerView: MCContainerView, didScrollToIndex index: Int)

    
    /// 做悬挂分类栏时候用到
    @objc optional func containerViewWillBeginDragging(_ containerView: MCContainerView)
    @objc optional func containerViewWilldidEndDragging(_ containerView: MCContainerView)
    
}



public class MCContainerView: UIView {
    
    /// 做悬挂分类栏时候用到
    public var currentChildPageViewController: MCPageChildViewController?
    
    public weak var delegate: MCContainerViewDelegate?
    
    /**
     * 根据数据直接创建
     */
    public func initContainerViewWithConfig(_ config: MCPageConfig) {
        
        settingWithConfig(config)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initBaseUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        /// 重置
        MCPageConfig.shared.empty()
    }
    
    
    // MARK: - Setter & Getter
    
    private lazy var pageVC: UIPageViewController = {
        let vc = UIPageViewController.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        vc.view.backgroundColor = UIColor.white
        vc.delegate = self
        vc.dataSource = self
        return vc
    }()
}




//MARK: UI的处理,通知的接收
private extension MCContainerView {
    
    private func settingWithConfig(_ config: MCPageConfig) {
        /// 检查配置
        if !isConfiguratioCorrect(config: config) {
            return
        }
        
        let index = MCPageConfig.shared.selectIndex
        
        // 指定当前的子控制器
        currentChildPageViewController = config.viewControllers[index] as? MCPageChildViewController
        
        /// 指定当前选中的viewController
        containerViewScrollToSubViewController(subIndex: index)
    }
    
    
    
    // 基础UI的设置
    private func initBaseUI() {
 
        self.addSubview(pageVC.view)
        pageVC.view.snp.remakeConstraints { (make) ->Void in
            make.left.right.bottom.top.equalTo(self)
        }
    }
    
    /// 检查配置
    private func isConfiguratioCorrect(config: MCPageConfig) -> Bool {
        if (config.categoryModels.count != config.viewControllers.count) ||
            config.categoryModels.count == 0 ||
            config.viewControllers.count == 0 {
            print("MCPageViewController:\n 请检查config的配置 config.vcs.count:\(config.categoryModels.count) --- config.vcs.count:\(config.viewControllers.count)")
            return false
        }
        
        if config.viewControllers.count <= config.selectIndex {
            print("MCPageViewController:\n 请检查config的配置config.selectIndex")
            return false
        }
        return true
    }
}


extension MCContainerView : UIScrollViewDelegate,UIPageViewControllerDelegate,UIPageViewControllerDataSource {
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let viewControllers = MCPageConfig.shared.viewControllers
        
        
        let index = viewControllers.index(of: viewController) ?? 0
        if index == viewControllers.count - 1 {
            return nil
        }
        return viewControllers[index + 1]
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        
        let viewControllers = MCPageConfig.shared.viewControllers
        
        
        let index = viewControllers.index(of: viewController) ?? 0
        if index == 0 {
            return nil
        }
        
        if let index = viewControllers.index(of: viewController) {
            return viewControllers[index - 1]
        } else {
            return nil
        }
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        let sub = pageViewController.viewControllers![0]
        var index = 0
        for subVc in MCPageConfig.shared.viewControllers {
            if subVc.isEqual(sub) {
                MCPageConfig.shared.selectIndex = index
                break
            }
            index += 1
        }
        
        /// 滑动了pageViewController，选中对应的分类tab
        currentChildPageViewController = MCPageConfig.shared.viewControllers[MCPageConfig.shared.selectIndex] as? MCPageChildViewController
        
        delegate?.containerView(self, didScrollToIndex: MCPageConfig.shared.selectIndex)
    }
    
    
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        delegate?.containerViewWillBeginDragging?(self)
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        delegate?.containerViewWilldidEndDragging?(self)
    }
    
}

extension MCContainerView {
    
    /// 更改选中的页面
    public func containerViewScrollToSubViewController(subIndex index: Int)  {
        let toPage = index
        let direction : UIPageViewController.NavigationDirection = MCPageConfig.shared.selectIndex > toPage ? .forward : .reverse
        
        pageVC.setViewControllers([MCPageConfig.shared.viewControllers[toPage]], direction: direction, animated: false) { [weak self] (finished) in
            MCPageConfig.shared.selectIndex = toPage;
            
            self?.currentChildPageViewController = MCPageConfig.shared.viewControllers[toPage] as? MCPageChildViewController
        }
    }
}

