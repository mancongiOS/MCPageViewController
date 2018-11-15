//
//  PageViewController.swift
//  MCPageViewController
//
//  Created by MC on 2018/11/5.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit

class PageViewController: MCPageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "页面联动";
        let titles = ["第1页","第2页","第3页","第4页","第5页","第6页","第7页","第8页","第9页","第10页"]

//        let titles = ["第1页","第2页"]

        
        let vcArrayM = NSMutableArray()
        
        let arrayM = NSMutableArray()
        
        
        for i in 0..<titles.count {
            let vc = SubViewController()
            vc.delegate = self
            vc.str = titles[i]
            vcArrayM.add(vc)
            
            let item = CustomButton()
            
            if i == 1 {
                item.tagImageView.image = #imageLiteral(resourceName: "hot")
                item.bgImageView.image = #imageLiteral(resourceName: "HOT_bg")
            }

            arrayM.add(item)
        }
        
        let config = MCPageConfig.init()
        config.titles = titles
        config.vcs = vcArrayM as! [UIViewController]
        config.blockWidth = 80
//        config.isLeftPosition = true
        
        
        initCustomPageWithConfig(config, items: arrayM as! [UIButton])
//        initPagesWithConfig(config)
    }
    

}

extension PageViewController : SubViewControllerProtocal {
    func jump(index: Int) {
        self.jumpToSubViewController(index)
    }
    
    func push() {
        let vc = NextViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
