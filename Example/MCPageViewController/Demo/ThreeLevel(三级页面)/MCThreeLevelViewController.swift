//
//  MCThreeLevelViewController.swift
//  MCPageViewController_Example
//
//  Created by 满聪 on 2019/6/27.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import MCPageViewController
import SnapKit


class MCThreeLevelViewController: UIViewController {
    // life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseSetting()
        
        
        createDataOne()
        loadPageViewControllerOne()
        
        
        createDataTwo()
        loadPageViewControllerTwo()
        
        initUI()
    }
    
    // MARK: - Setter & Getter
    lazy var segmented: UISegmentedControl = {
        let items = ["卖出的","买入的"]
        let seg = UISegmentedControl.init(items: items)
        seg.selectedSegmentIndex = 0
        seg.frame = CGRect.init(x: 0, y: 0, width: 200, height: 30)
    
        seg.addTarget(self, action: #selector(segmentedEvent(sender:)), for: UIControl.Event.valueChanged)
        return seg
    }()
    
    lazy var fatherScrollView: UIScrollView = {
        let sc = UIScrollView()
        sc.isPagingEnabled = true
        sc.delegate = self
        sc.contentSize = CGSize.init(width: UIDevice.width * 2, height: 0)
        return sc
    }()
    
    
    /// ====  pageViewController的设置    ====//
    /// 分类条
    lazy var categoryBarOne: MCCategoryBar = {
        let view = MCCategoryBar()
        view.delegate = self
        return view
    }()
    
    /// 内容容器
    lazy var containerViewOne: MCContainerView = {
        let view = MCContainerView()
        view.delegate = self
        return view
    }()
    
    var vcArrayOne: [UIViewController] = []
    var modelArrayOne: [MCCategoryBarModel] = []
    
    
    
    
    lazy var categoryBarTwo: MCCategoryBar = {
        let view = MCCategoryBar()
        view.delegate = self
        return view
    }()
    
    /// 内容容器
    lazy var containerViewTwo: MCContainerView = {
        let view = MCContainerView()
        view.delegate = self
        return view
    }()
    
    var vcArrayTwo: [UIViewController] = []
    var modelArrayTwo: [MCCategoryBarModel] = []
}

//MARK: 通知回调，闭包回调，点击事件
extension MCThreeLevelViewController {
    @objc func segmentedEvent(sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        
        if index == 0 {
            fatherScrollView.contentOffset = CGPoint.init(x: 0, y: 0)
        } else {
            fatherScrollView.contentOffset = CGPoint.init(x: UIDevice.width, y: 0)
        }
    }
}
//MARK: UI的处理,通知的接收
extension MCThreeLevelViewController {
    
    func baseSetting() {
        view.backgroundColor = UIColor.white
    }
    
    func initUI() {
        navigationItem.titleView = segmented
        
        
        view.addSubview(fatherScrollView)
        fatherScrollView.snp.remakeConstraints { (make) ->Void in
            make.edges.equalTo(view)
        }
        

        initUIOne()
        initUITwo()
    }
    
    
}

extension MCThreeLevelViewController {
    
    func initUIOne() {
        fatherScrollView.addSubview(categoryBarOne)
        categoryBarOne.snp.remakeConstraints { (make) ->Void in
            make.left.top.equalTo(fatherScrollView)
            make.width.equalTo(UIDevice.width)
            make.height.equalTo(40)
        }
        
        
        fatherScrollView.addSubview(containerViewOne)
        containerViewOne.snp.remakeConstraints { (make) ->Void in
            make.top.equalTo(categoryBarOne.snp.bottom)
            make.height.equalTo(UIDevice.height - UIDevice.navigationBarHeight - 40)
            make.left.equalTo(categoryBarOne)
            make.width.equalTo(UIDevice.width)
        }
    }
    
    func createDataOne() {
        
        for i in 0..<4 {
            
            let model = MCCategoryBarModel()
            let titleStr = String(i) + "页"
            model.title = titleStr
            
            let vc = MCBasicUseSubViewController()
            vc.pageExplain = titleStr
            vc.fatherViewController = self
            vcArrayOne.append(vc)
            modelArrayOne.append(model)
        }
    }

    
    func loadPageViewControllerOne() {
        
        let config = MCPageConfig()
        
        config.viewControllers = vcArrayOne
        config.categoryModels = modelArrayOne
        config.defaultIndex = 0
        config.category.maxTitleCount = 10
        
        
        categoryBarOne.initCategoryBarWithConfig(config)
        containerViewOne.initContainerViewWithConfig(config)
    }

}

extension MCThreeLevelViewController {
    
    func initUITwo() {
        fatherScrollView.addSubview(categoryBarTwo)
        categoryBarTwo.snp.remakeConstraints { (make) ->Void in
            make.top.equalTo(fatherScrollView)
            make.left.equalTo(UIDevice.width)
            make.width.equalTo(UIDevice.width)
            make.height.equalTo(40)
        }
        
        
        fatherScrollView.addSubview(containerViewTwo)
        containerViewTwo.snp.remakeConstraints { (make) ->Void in
            make.top.equalTo(categoryBarTwo.snp.bottom)
            make.height.equalTo(UIDevice.height - UIDevice.navigationBarHeight - 40)
            make.left.equalTo(categoryBarTwo)
            make.width.equalTo(UIDevice.width)
        }
    }
    
    func createDataTwo() {
        
        for i in 0..<4 {
            
            let model = MCCategoryBarModel()
            let titleStr = "第" + String(i)
            model.title = titleStr
            
            let vc = MCBasicUseSubViewController()
            vc.pageExplain = titleStr
            vc.fatherViewController = self
            vcArrayTwo.append(vc)
            modelArrayTwo.append(model)
        }
    }
    
    
    func loadPageViewControllerTwo() {
        
        let config = MCPageConfig()
        
        config.viewControllers = vcArrayTwo
        config.categoryModels = modelArrayTwo
        config.defaultIndex = 0
        config.category.maxTitleCount = 10
        
        
        categoryBarTwo.initCategoryBarWithConfig(config)
        containerViewTwo.initContainerViewWithConfig(config)
    }
    
}



//MARK: 代理方法

extension MCThreeLevelViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let ofset = scrollView.contentOffset
        
        let index = ofset.x / UIDevice.width
        
        segmented.selectedSegmentIndex = Int(index)
    }
}




extension MCThreeLevelViewController: MCCategoryBarDelegate {
    func categoryBar(categoryBar: MCCategoryBar, didSelectItemAt index: Int) {
       
        
        if categoryBar == categoryBarOne {
            containerViewOne.containerViewScrollToSubViewController(subIndex: index)
        } else {
            containerViewTwo.containerViewScrollToSubViewController(subIndex: index)
        }

    }
}

extension MCThreeLevelViewController: MCContainerViewDelegate {
    
    func containerView(_ containerView: MCContainerView, didScrollToIndex index: Int) {
        
        if containerView == containerViewOne {
            categoryBarOne.categoryBarDidClickItem(at: index)
        } else {
            categoryBarTwo.categoryBarDidClickItem(at: index)
        }
    }
}
