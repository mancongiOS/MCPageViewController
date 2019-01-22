//
//  ViewController.swift
//  MCPageViewController
//
//  Created by 562863544@qq.com on 01/22/2019.
//  Copyright (c) 2019 562863544@qq.com. All rights reserved.
//


import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "欢迎页"
        
        let navigationBar = navigationController?.navigationBar
        navigationBar?.isTranslucent = false
        navigationBar?.setBackgroundImage(UIImage.init(named: ""), for: .default)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let vc = PageViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

