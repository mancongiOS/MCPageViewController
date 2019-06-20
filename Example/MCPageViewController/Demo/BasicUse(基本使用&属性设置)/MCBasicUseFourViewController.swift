//
//  MCBasicUseFourViewController.swift
//  MCPageViewController_Example
//
//  Created by 满聪 on 2019/6/20.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

import MCComponentPublicUI
import MCPageViewController


class MCBasicUseFourViewController: MCBasicUseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


        loadPageViewController()
        
        initUI()
    }
    
    lazy var showButton = UIButton.mc_make(text: "更多", font: UIFont.mc15, textColor: UIColor.red, backgroundColor: UIColor.lightGray, target: self, selector: #selector(event))
    lazy var searchButton = UIButton.mc_make(text: "搜索", font: UIFont.mc15, textColor: UIColor.red, backgroundColor: UIColor.lightGray, target: self, selector: #selector(event))

    
    
    func initUI() {
        
        navigationItem.title = "分类栏设置左右控件"
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
        
        categoryBar.addSubview(showButton)
        showButton.snp.remakeConstraints { (make) ->Void in
            make.top.bottom.right.equalTo(0)
            make.width.equalTo(50)
        }
        
        
        categoryBar.addSubview(searchButton)
        searchButton.snp.remakeConstraints { (make) ->Void in
            make.top.bottom.left.equalTo(0)
            make.width.equalTo(50)
        }
    }
    
    func loadPageViewController() {
        
        let config = MCPageConfig()
        
        config.viewControllers = vcArray
        config.categoryModels = modelArray
        config.defaultIndex = 0
        
        config.category.inset = (50, 50)
        
        categoryBar.initCategoryBarWithConfig(config)
        containerView.initContainerViewWithConfig(config)
    }
}


extension MCBasicUseFourViewController {
    
    @objc func event() {
        print("点击了")
    }
}
