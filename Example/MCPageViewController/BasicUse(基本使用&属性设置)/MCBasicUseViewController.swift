//
//  MCNormalOneViewController.swift
//  MCPageViewController_Example
//
//  Created by 满聪 on 2019/6/3.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import MCPageViewController

class MCBasicUseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initUI()
        
        createData()
        
        loadPageViewController()
    }
    
    /// 分类条
    lazy var categoryBar: MCCategoryBar = {
        let view = MCCategoryBar()
        view.delegate = self
        return view
    }()
    
    /// 内容容器
    lazy var containerView: MCContainerView = {
        let view = MCContainerView()
        view.delegate = self
        return view
    }()
    
    var vcArray: [UIViewController] = []
    var modelArray: [MCCategoryBarModel] = []
}

extension MCBasicUseViewController {
    func initUI() {
        
        navigationItem.title = "基本使用"
        view.backgroundColor = UIColor.white
        
        view.addSubview(categoryBar)
        categoryBar.snp.remakeConstraints { (make) ->Void in
            make.left.right.top.equalTo(view)
            make.height.equalTo(40)
        }

        
        view.addSubview(containerView)
        containerView.snp.remakeConstraints { (make) ->Void in
            make.left.right.bottom.equalTo(view)
            make.top.equalTo(categoryBar.snp.bottom)
        }
    }
    
    func createData() {
        
        for i in 0..<10 {
            
            let model = MCCategoryBarModel()
            let title = "第" + String(i) + "页"
            model.title = title
            
            let vc = NormalSubViewController()
            vc.pageExplain = title
            vcArray.append(vc)
            modelArray.append(model)
        }
    }
    
    
    
    
    func loadPageViewController() {
        
        /// 一定要使用这个单例。 详细的功能配置请看 MCPageConfig这个类
        let config = MCPageConfig.shared
        
        
        config.selectIndex = 0
        config.viewControllers = vcArray
        config.categoryModels = modelArray

        
        config.category.normalColor = UIColor.gray
        config.category.selectedColor = UIColor.red
        config.category.normalFont = UIFont.mc14
        config.category.selectFont = UIFont.mc16
        
        // 隐藏底部分割线
//        config.category.isHiddenLine = true
        
        
        config.indicator.height = 5
        config.indicator.cornerRadius = 2.5
        config.indicator.backgroundColor = UIColor.purple
        
        categoryBar.initCategoryBarWithConfig(config)
        containerView.initContainerViewWithConfig(config)
    }
}


extension MCBasicUseViewController: MCCategoryBarDelegate {
    func categoryBar(categoryBar: MCCategoryBar, didSelectItemAt index: Int) {
        print("didSelectItemAt \(index)")
        containerView.containerViewScrollToSubViewController(subIndex: index)
    }
}

extension MCBasicUseViewController: MCContainerViewDelegate {
    
    func containerView(_ containerView: MCContainerView, didScrollToIndex index: Int) {
        print("didScrollToIndex \(index)")
        categoryBar.categoryBarDidClickItem(at: index)
    }
}
