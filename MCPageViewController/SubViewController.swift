//
//  SubViewController.swift
//  MCPageViewController
//
//  Created by MC on 2018/11/5.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit

class SubViewController: UIViewController {

    public var str = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        title = str
        
        
        let label = UILabel()
        label.text = str
        label.textColor = UIColor.red
        view.addSubview(label)
        
        label.frame = CGRect.init(x: 10, y: 10, width: 200, height: 200)
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
