//
//  CustomButton.swift
//  MCPageViewController
//
//  Created by MC on 2018/11/6.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit

class CustomButton: MCPageItem {


    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.bgImageView.backgroundColor = UIColor.white
    }
    
    
    
    // UI布局等需要写在此处
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
