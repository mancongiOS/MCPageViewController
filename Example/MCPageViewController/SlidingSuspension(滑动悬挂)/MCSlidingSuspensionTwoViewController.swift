//
//  MCSlidingSuspensionTwoViewController.swift
//  MCPageViewController_Example
//
//  Created by 满聪 on 2019/6/4.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

import MJRefresh
import MCComponentExtension
import MCPageViewController


import SnapKit
class MCSlidingSuspensionTwoViewController: UIViewController {
    
    
    /// 当前页面是否 不能滑动
    private var cannotScroll: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "滑动悬停分类栏"
        
        initUI()
        
        createData()
        
        loadPageViewController()
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
    
    lazy var sectionHeader: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.frame = CGRect.init(x: 0, y: 0, width: 0, height: 200)
        return view
    }()
    
    lazy var sectionFooter: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.green
        
        /// sectionFooter的height 为 UIDevice.height
        view.frame = CGRect.init(x: 0, y: 0, width: 0, height: UIDevice.height)
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
    
    var vcArray: [UIViewController] = []
    var modelArray: [MCCategoryBarModel] = []
    
}

extension MCSlidingSuspensionTwoViewController: UITableViewDelegate, UITableViewDataSource {
    
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


extension MCSlidingSuspensionTwoViewController {
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
        
        
        
        tableView.tableHeaderView = sectionHeader
        tableView.tableFooterView = sectionFooter
        
        
        sectionFooter.addSubview(categoryBar)
        categoryBar.snp.remakeConstraints { (make) ->Void in
            make.left.right.top.equalTo(sectionFooter)
            make.height.equalTo(40)
        }
        
        
        /// containerView注意设置的高度
        sectionFooter.addSubview(containerView)
        containerView.snp.remakeConstraints { (make) ->Void in
            make.left.right.equalTo(sectionFooter)
            make.top.equalTo(categoryBar.snp.bottom)
            make.bottom.equalTo(-UIDevice.navigationBarHeight)
        }
    }
    
    func createData() {
        
        for i in 0..<10 {
            
            let model = MCCategoryBarModel()
            let title = "第" + String(i) + "页"
            model.title = title
            
            
            /// 注意 SlidingSuspensionChildViewController继承的类
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
}





extension MCSlidingSuspensionTwoViewController: MCPageChildViewControllerDelegate {
    func pageChildViewControllerLeaveTop(_ childViewController: MCPageChildViewController) {
        cannotScroll = false
    }
}



extension MCSlidingSuspensionTwoViewController {
    
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        return true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        //第二部分：处理scrollView滑动冲突
        let contentOffsetY = scrollView.contentOffset.y
        //吸顶临界点(此时的临界点不是视觉感官上导航栏的底部，而是当前屏幕的顶部相对scrollViewContentView的位置)
        let criticalPointOffsetY = scrollView.contentSize.height - UIDevice.height
        
        
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



extension MCSlidingSuspensionTwoViewController: MCCategoryBarDelegate {
    func categoryBar(categoryBar: MCCategoryBar, didSelectItemAt index: Int) {
        print("didSelectItemAt \(index)")
        containerView.containerViewScrollToSubViewController(subIndex: index)
    }
}

extension MCSlidingSuspensionTwoViewController: MCContainerViewDelegate {
    
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
