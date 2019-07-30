//
//  MCBadgeOneViewController.swift
//  MCPageViewController_Example
//
//  Created by 满聪 on 2019/7/30.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit


import MCPageViewController


class MCBadgeOneViewController: MCBasicUseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.mc_setText("修改badge", target: self, selector: #selector(badgeEvent))
        
        loadPageViewController()
        
        initUI()
    }
    
    
    func initUI() {
        
        navigationItem.title = "Badge"
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
        
    }
    
    func loadPageViewController() {
        
        vcArray.removeAll()
        modelArray.removeAll()
        
        for i in 0..<3 {
            
            let model = MCCategoryBarModel()
            let titleStr = "第" + String(i) + "页"
            
            model.title = titleStr
            
            switch i {
            case 0:
                model.badgeValue = "1"
            case 1:
                model.badgeValue = nil
            case 2:
                model.badgeValue = "999"

            default:
                break
            }

            
            
            let vc = MCBasicUseSubViewController()
            vc.delegate = self
            vc.pageExplain = titleStr
            vc.fatherViewController = self
            vcArray.append(vc)
            modelArray.append(model)
        }

        
        
        
        let config = MCPageConfig()
        
        config.viewControllers = vcArray
        config.categoryModels = modelArray
        config.defaultIndex = 0
        config.category.maxTitleCount = 10
        config.category.itemWidth = 80
        
        config.badge.isHidden = false
        config.badge.backgroundColor = UIColor.red
        config.badge.badgeOffset = CGPoint.init(x: 5, y: -3)
        config.badge.badgeTextColor = UIColor.white
        config.badge.badgeTextFont = UIFont.mc10
        config.badge.isDoc = false
        
        categoryBar.initCategoryBarWithConfig(config)
        containerView.initContainerViewWithConfig(config)
    }
}

extension MCBadgeOneViewController {
    
    // 更改未读消息的数据
    @objc func badgeEvent() {
        let model = modelArray[0]
        model.badgeValue = nil
        categoryBar.updateCategoryModel(model, atIndex: 0)
    }
}

