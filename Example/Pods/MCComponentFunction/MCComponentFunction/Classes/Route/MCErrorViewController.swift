//
//  MCErrorViewController.swift
//  MCAPI
//
//  Created by MC on 2018/11/26.
//  Copyright © 2018 MC. All rights reserved.
//

import UIKit

public class MCErrorViewController: UIViewController {

    var errorView : UIView? = nil
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        if errorView != nil {
            self.view .addSubview(errorView!)
        }
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
