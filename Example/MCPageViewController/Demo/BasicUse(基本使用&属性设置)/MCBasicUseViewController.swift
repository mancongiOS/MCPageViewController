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
        
        
        createData()
        
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
    
    func createData() {
        
        for i in 0..<10 {
            
            let model = MCCategoryBarModel()
            let titleStr = "第" + String(i) + "页"
            
            
//            if i % 2 == 0 {
//                titleStr = "这是加长的" + titleStr
//            }
//
            
            model.title = titleStr
            
            let vc = MCBasicUseSubViewController()
            vc.delegate = self
            vc.pageExplain = titleStr
            vc.fatherViewController = self
            vcArray.append(vc)
            modelArray.append(model)
            self.addChild(vc)
        }
    }
}


extension MCBasicUseViewController: MCCategoryBarDelegate {
    func categoryBar(categoryBar: MCCategoryBar, didSelectItemAt index: Int) {
        containerView.containerViewScrollToSubViewController(subIndex: index)
    }
}

extension MCBasicUseViewController: MCContainerViewDelegate {
    
    func containerView(_ containerView: MCContainerView, didScrollToIndex index: Int) {
        categoryBar.categoryBarDidClickItem(at: index)
    }
}

extension MCBasicUseViewController: JumpToOtherIndex {
    func jumpToOtherIndex(_ index: Int) {
        containerView.containerViewScrollToSubViewController(subIndex: index)
        categoryBar.categoryBarDidClickItem(at: index)
    }
}
