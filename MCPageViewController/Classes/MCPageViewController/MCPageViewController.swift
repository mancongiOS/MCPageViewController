//
//  MCPageViewController.swift
//  MCPageViewController
//
//  Created by MC on 2018/11/2.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit


public protocol MCPageViewControllerDelegate: NSObjectProtocol {
    
    func pageViewControllerWillBeginDragging(_ pageViewController: MCPageViewController)
    func pageViewControllerDidEndDragging(_ pageViewController: MCPageViewController)
    func pageViewControllerClickMoreEvent(_ pageViewController: MCPageViewController)
}


open class MCPageViewController: UIViewController {
    
    
    public var currentChildPageViewController: MCPageChildViewController?
    
    public weak var delegate: MCPageViewControllerDelegate?
    
    /**
     * 根据数据直接创建
     */
    public func initPagesWithConfig(_ config: MCPageConfig) {
        
        categoryView.categoryModels = config.categoryModels

        settingWithConfig(config)
    }
    
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        initBaseUI()
    }
    
    
    
    // MARK: - Setter & Getter
    private lazy var categoryView: MCCategoryBar = {
        let view = MCCategoryBar()
        view.changeItemWithTargetIndex(targetIndex: 0)
        view.delegate = self
        return view
    }()
    
    private lazy var pageVC: UIPageViewController = {
        let vc = UIPageViewController.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        vc.delegate = self
        vc.dataSource = self
        return vc
    }()
}




//MARK: UI的处理,通知的接收
private extension MCPageViewController {
    
    private func settingWithConfig(_ config: MCPageConfig) {
       
        
        
        if (config.categoryModels.count != config.viewControllers.count) || config.categoryModels.count == 0 || config.viewControllers.count == 0 {
            print("MCPageViewController: 请检查config的配置 config.vcs.count:\(config.categoryModels.count) --- config.vcs.count:\(config.viewControllers.count)")
            return
        }
        
        
        

        let index = MCPageConfig.shared.selectIndex
        
        // 指定当前的子控制器
        currentChildPageViewController = config.viewControllers[index] as? MCPageChildViewController
        
        /// 指定当前选中的tab 和  当前选中的viewController
        changeSelectCategoryView(selectIndex: index)
        changeSelectPageViewController(selectPage: index)
    }
    
    
    
    // 基础UI的设置
    private func initBaseUI() {
        
        
        self.view.backgroundColor = UIColor.white

        
        self.view.addSubview(categoryView)
        categoryView.snp.remakeConstraints { (make) ->Void in
            make.left.right.top.equalTo(view)
            make.height.equalTo(50)
        }
        
        
        view.addSubview(pageVC.view)
        pageVC.view.snp.remakeConstraints { (make) ->Void in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(categoryView.snp.bottom)
        }

    }
}


extension MCPageViewController : UIScrollViewDelegate,UIPageViewControllerDelegate,UIPageViewControllerDataSource {
    
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
            if subVc.isEqual(sub) { MCPageConfig.shared.selectIndex = index }
            index += 1
        }
        
        /// 滑动了pageViewController，选中对应的分类tab
        changeSelectCategoryView(selectIndex: MCPageConfig.shared.selectIndex)
        currentChildPageViewController = MCPageConfig.shared.viewControllers[MCPageConfig.shared.selectIndex] as? MCPageChildViewController
    }
    
    
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        delegate?.pageViewControllerWillBeginDragging(self)
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        delegate?.pageViewControllerDidEndDragging(self)
    }
    
}

extension MCPageViewController {
    
    /// 更改选中的分类
    func changeSelectCategoryView(selectIndex targetIndex: Int) {
        categoryView.changeItemWithTargetIndex(targetIndex: targetIndex)
    }
    
    /// 更改选中的页面
    func changeSelectPageViewController(selectPage pageIndex: Int)  {
        let toPage = pageIndex
        let direction : UIPageViewController.NavigationDirection = MCPageConfig.shared.selectIndex > toPage ? .forward : .reverse
        
        pageVC.setViewControllers([MCPageConfig.shared.viewControllers[toPage]], direction: direction, animated: false) { (finished) in
            MCPageConfig.shared.selectIndex = toPage;
            
            self.currentChildPageViewController = MCPageConfig.shared.viewControllers[toPage] as? MCPageChildViewController
        }
    }
}

extension MCPageViewController: MCCategoryBarDelegate {
    public func categoryBarClickMoreEvent(categoryBar: MCCategoryBar) {
        delegate?.pageViewControllerClickMoreEvent(self)
    }
    
    
    /// 选中了分类tab，滑动到对应的页面
    public func categoryBar(categoryBar: MCCategoryBar, didSelectItemAt index: Int) {
        changeSelectPageViewController(selectPage: index)
        
        currentChildPageViewController = MCPageConfig.shared.viewControllers[index] as? MCPageChildViewController
        MCPageConfig.shared.selectIndex = index
    }
}
