//
//  ViewController.swift
//  MCPageViewController
//
//  Created by MC on 2018/11/2.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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

