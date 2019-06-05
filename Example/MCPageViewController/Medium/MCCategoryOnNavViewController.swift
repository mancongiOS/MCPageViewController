//
//  MCCategoryOnNavViewController.swift
//  MCPageViewController_Example
//
//  Created by 满聪 on 2019/6/4.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

import MCPageViewController

class MCCategoryOnNavViewController: UIViewController {
    
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

extension MCCategoryOnNavViewController {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    func initUI() {
        view.backgroundColor = UIColor.white
        
        categoryBar.backgroundColor = UIColor.red

        categoryBar.frame = CGRect.init(x: 0, y: 0, width: 100, height: 44)
        self.navigationItem.titleView = categoryBar

        view.addSubview(containerView)
        containerView.snp.remakeConstraints { (make) ->Void in
            make.edges.equalTo(view)
        }
    }
    
    func createData() {
        
        let titles = ["第0页","第1页","第2页"]
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
        config.category.selectFont = UIFont.mc12
        config.selectIndex = 0
        config.viewControllers = vcArray
        config.categoryModels = modelArray
        
        
        categoryBar.initCategoryBarWithConfig(config)
        containerView.initContainerViewWithConfig(config)
    }
}


extension MCCategoryOnNavViewController: MCCategoryBarDelegate {
    func categoryBar(categoryBar: MCCategoryBar, didSelectItemAt index: Int) {
        print("didSelectItemAt \(index)")
        containerView.containerViewScrollToSubViewController(subIndex: index)
    }
}

extension MCCategoryOnNavViewController: MCContainerViewDelegate {
    
    func containerView(_ containerView: MCContainerView, didScrollToIndex index: Int) {
        print("didScrollToIndex \(index)")
        categoryBar.categoryBarDidClickItem(at: index)
    }
}

