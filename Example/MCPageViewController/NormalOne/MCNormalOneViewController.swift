//
//  MCNormalOneViewController.swift
//  MCPageViewController_Example
//
//  Created by 满聪 on 2019/6/3.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import MCPageViewController

class MCNormalOneViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initUI()
        
        createData()
        
        loadPageViewController()
    }
    
    
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

extension MCNormalOneViewController {
    func initUI() {
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
        
        let titles = ["第0页","第1页"]
        for title in titles {
            
            let model = MCCategoryBarModel()
            model.title = title
            
            let vc = NormalSubViewController()
            vc.pageExplain = title
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


extension MCNormalOneViewController: MCCategoryBarDelegate {
    func categoryBar(categoryBar: MCCategoryBar, didSelectItemAt index: Int) {
        print("didSelectItemAt \(index)")
        containerView.containerViewScrollToSubViewController(subIndex: index)
    }
}

extension MCNormalOneViewController: MCContainerViewDelegate {
    
    func containerView(_ containerView: MCContainerView, didScrollToIndex index: Int) {
        print("didScrollToIndex \(index)")
        categoryBar.categoryBarDidClickItem(at: index)
    }
}
