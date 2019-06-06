//
//  MCSlidingSuspensionViewController.swift
//  MCPageViewController_Example
//
//  Created by 满聪 on 2019/6/3.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

import MJRefresh
import MCComponentExtension
import MCPageViewController


import SnapKit
class MCSlidingSuspensionViewController: UIViewController {
    
    
    /// 当前页面是否 不能滑动
    private var cannotScroll: Bool = false


    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
        createData()
        
        loadPageViewController()
    }
    
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
        updateStatusBarCoverColor()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    
    lazy var tableView: MCBaseTableView = {
        let tb = MCBaseTableView.init(frame: CGRect.zero, style: .plain)
        tb.delegate = self
        tb.dataSource = self
        tb.separatorStyle = .none
        tb.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        
        if #available(iOS 11.0, *) {
            tb.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        return tb
    }()
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.frame = CGRect.init(x: 0, y: 0, width: 0, height: 200)
        return view
    }()
    
    lazy var footerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.green
        
    
        view.frame = CGRect.init(x: 0, y: 0, width: 0, height: UIDevice.height - UIDevice.topSafeAreaHeight)
        return view
    }()
    
    
    lazy var categoryBar: MCCategoryBar = {
        let view = MCCategoryBar()
        view.delegate = self
        return view
    }()
    
    
    lazy var containerView: MCContainerView = {
        let view = MCContainerView()
        view.delegate = self
        return view
    }()
    
    lazy var statusBarCoverView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.alpha = 0
        return view
    }()

    
    var vcArray: [UIViewController] = []
    var modelArray: [MCCategoryBarModel] = []

}

extension MCSlidingSuspensionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}


extension MCSlidingSuspensionViewController {
    func initUI() {
        view.addSubview(tableView)
        tableView.snp.remakeConstraints { (make) ->Void in
            make.edges.equalTo(view)
        }
        
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                self.tableView.mj_header.endRefreshing()
            })
        })
        

        
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView

        
        footerView.addSubview(categoryBar)
        categoryBar.snp.remakeConstraints { (make) ->Void in
            make.left.right.top.equalTo(footerView)
            make.height.equalTo(40)
        }
        
        
        footerView.addSubview(containerView)
        containerView.snp.remakeConstraints { (make) ->Void in
            make.left.right.bottom.equalTo(footerView)
            make.top.equalTo(categoryBar.snp.bottom)
        }
        
        view.addSubview(statusBarCoverView)
        statusBarCoverView.snp.remakeConstraints { (make) ->Void in
            make.left.top.right.equalTo(view)
            make.height.equalTo(UIDevice.statusBarHeight)
        }
    }
    
    func createData() {
        
        for i in 0..<10 {
            
            let model = MCCategoryBarModel()
            let title = "第" + String(i) + "页"
            model.title = title
            
            let vc = SlidingSuspensionChildViewController()
            vc.delegate = self
            vc.pageExplain = title
            vc.fatherViewController = self
            vcArray.append(vc)
            modelArray.append(model)
        }

    }
    
    func loadPageViewController() {
        
        
        /// 一定要使用这个单例
        let config = MCPageConfig.shared
        config.category.normalColor = UIColor.gray
        config.category.selectedColor = UIColor.orange
        config.category.normalFont = UIFont.mc12
        config.category.selectFont = UIFont.mc22
        config.selectIndex = 0
        config.viewControllers = vcArray
        config.categoryModels = modelArray
        
        
        
        config.indicator.height = 3
        config.indicator.cornerRadius = 1.5
        config.indicator.backgroundColor = UIColor.purple
        
        categoryBar.initCategoryBarWithConfig(config)
        containerView.initContainerViewWithConfig(config)
    }
    
    
    
    /// 更改状态栏覆盖层的透明度
    func updateStatusBarCoverColor() {
        
        
        var alpha:CGFloat = 0
        
        if tableView.contentOffset.y < headerView.frame.height - UIDevice.statusBarHeight - 1 {
            alpha = 0
            UIApplication.shared.statusBarStyle = .default
        } else {
            alpha = 1
            UIApplication.shared.statusBarStyle = .lightContent
        }
        statusBarCoverView.alpha = alpha
    }

}





extension MCSlidingSuspensionViewController: MCPageChildViewControllerDelegate {
    func pageChildViewControllerLeaveTop(_ childViewController: MCPageChildViewController) {
        cannotScroll = false
    }
}



extension MCSlidingSuspensionViewController {
    
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        return true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        /// 1. 更改状态栏的透明度
        updateStatusBarCoverColor()
        
        
        let contentOffsetY = scrollView.contentOffset.y
        let contentSizeHeight = scrollView.contentSize.height
        
        //2.处理scrollView滑动冲突
        //吸顶临界点
        let criticalPointOffsetY = contentSizeHeight - UIDevice.height
        
        
        //利用contentOffset处理内外层scrollView的滑动冲突问题
        if (contentOffsetY >= criticalPointOffsetY) {
            /*
             * 到达临界点：
             * 1.未吸顶状态 -> 吸顶状态
             * 2.维持吸顶状态 (pageViewController.scrollView.contentOffsetY > 0)
             */
            //“进入吸顶状态”以及“维持吸顶状态”
            self.cannotScroll = true
            
            scrollView.contentOffset = CGPoint.init(x: 0, y: criticalPointOffsetY)
            containerView.currentChildPageViewController?.makePageViewControllerScroll(canScroll: true)
        } else {
            /*
             * 未达到临界点：
             * 1.维持吸顶状态 (pageViewController.scrollView.contentOffsetY > 0)
             * 2.吸顶状态 -> 不吸顶状态
             */
            if (self.cannotScroll) {
                //“维持吸顶状态”
                scrollView.contentOffset = CGPoint.init(x: 0, y: criticalPointOffsetY)
            } else {
                /* 吸顶状态 -> 不吸顶状态
                 * categoryView的子控制器的tableView或collectionView在竖直方向上的contentOffsetY小于等于0时，会通过代理的方式改变当前控制器self.canScroll的值；
                 */
            }
        }
    }
}



extension MCSlidingSuspensionViewController: MCCategoryBarDelegate {
    func categoryBar(categoryBar: MCCategoryBar, didSelectItemAt index: Int) {
        print("didSelectItemAt \(index)")
        containerView.containerViewScrollToSubViewController(subIndex: index)
    }
}

extension MCSlidingSuspensionViewController: MCContainerViewDelegate {
    
    func containerViewWillBeginDragging(_ containerView: MCContainerView) {
        tableView.isScrollEnabled = false
    }
    
    func containerViewWilldidEndDragging(_ containerView: MCContainerView) {
        tableView.isScrollEnabled = true
    }
    
    func containerView(_ containerView: MCContainerView, didScrollToIndex index: Int) {
        print("didScrollToIndex \(index)")
        categoryBar.categoryBarDidClickItem(at: index)
    }
}
