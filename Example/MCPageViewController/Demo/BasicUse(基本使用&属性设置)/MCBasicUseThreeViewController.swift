//
//  MCBasicUseThreeViewController.swift
//  MCPageViewController_Example
//
//  Created by 满聪 on 2019/6/20.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import MCPageViewController

class MCBasicUseThreeViewController: MCBasicUseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        loadPageViewController()
        
        initUI()
    }
    
    func initUI() {
        
        navigationItem.title = "设置分割线"
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
    
    func loadPageViewController() {
        
        let config = MCPageConfig()
        
        config.viewControllers = vcArray
        config.categoryModels = modelArray

        config.separator.backgroundColor = UIColor.red
        config.separator.height = 5
        
        
        categoryBar.initCategoryBarWithConfig(config)
        containerView.initContainerViewWithConfig(config)
    }
}
