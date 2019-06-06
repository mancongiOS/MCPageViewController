//
//  MCNormalTwoViewController.swift
//  MCPageViewController_Example
//
//  Created by 满聪 on 2019/6/4.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

import MCPageViewController

import MCComponentPublicUI

class MCNormalTwoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.title = "分类栏添加元素"
        
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
    
    lazy var showButton = UIButton.mc_make(text: "更多", font: UIFont.mc15, textColor: UIColor.red, backgroundColor: UIColor.lightGray, target: self, selector: #selector(event))
    lazy var searchButton = UIButton.mc_make(text: "搜索", font: UIFont.mc15, textColor: UIColor.red, backgroundColor: UIColor.lightGray, target: self, selector: #selector(event))
}


extension MCNormalTwoViewController {

    @objc func event() {
        print("点击了")
    }
}


extension MCNormalTwoViewController {
    func initUI() {
        view.backgroundColor = UIColor.white
        
        view.addSubview(categoryBar)
        categoryBar.snp.remakeConstraints { (make) ->Void in
            make.left.right.top.equalTo(view)
            make.height.equalTo(50)
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
        
        /// 一定要使用这个单例
        let config = MCPageConfig.shared
        
        config.selectIndex = 0
        config.viewControllers = vcArray
        config.categoryModels = modelArray
        
        
        config.category.normalColor = UIColor.gray
        config.category.selectedColor = UIColor.red
        config.category.normalFont = UIFont.mc15
        config.category.selectFont = UIFont.mc16

        /// 设置左右边距
        config.category.inset = (50, 50)
        
        categoryBar.initCategoryBarWithConfig(config)
        containerView.initContainerViewWithConfig(config)
    }
}


extension MCNormalTwoViewController: MCCategoryBarDelegate {
    func categoryBar(categoryBar: MCCategoryBar, didSelectItemAt index: Int) {
        print("didSelectItemAt \(index)")
        containerView.containerViewScrollToSubViewController(subIndex: index)
    }
}

extension MCNormalTwoViewController: MCContainerViewDelegate {
    
    func containerView(_ containerView: MCContainerView, didScrollToIndex index: Int) {
        print("didScrollToIndex \(index)")
        categoryBar.categoryBarDidClickItem(at: index)
    }
}

