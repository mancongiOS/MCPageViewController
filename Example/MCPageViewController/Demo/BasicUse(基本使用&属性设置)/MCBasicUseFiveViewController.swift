//
//  MCBasicUseFiveViewController.swift
//  MCPageViewController_Example
//
//  Created by 满聪 on 2019/6/20.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import MCPageViewController

class MCBasicUseFiveViewController: MCBasicUseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        loadPageViewController()
        
        initUI()
    }
    
    
    func initUI() {
        
        navigationItem.title = "分类栏在导航栏上"
        view.backgroundColor = UIColor.white
        
        categoryBar.frame = CGRect.init(x: 0, y: 0, width: 300, height: 44)
        self.navigationItem.titleView = categoryBar

        
        view.addSubview(containerView)
        containerView.snp.remakeConstraints { (make) ->Void in
            make.edges.equalTo(view)
        }
    }
    
    func loadPageViewController() {
        
        let config = MCPageConfig()
        
    
        config.viewControllers = vcArray
        config.categoryModels = modelArray
        config.defaultIndex = 0
        config.category.maxTitleCount = 10
        config.separator.isHidden = true
        config.category.itemWidth = 150
        config.category.itemSpacing = 0
        config.category.barBackgroundColor = UIColor.orange
        config.category.itemBackgroundColor = UIColor.yellow
        
        categoryBar.initCategoryBarWithConfig(config)
        containerView.initContainerViewWithConfig(config)
    }
}
