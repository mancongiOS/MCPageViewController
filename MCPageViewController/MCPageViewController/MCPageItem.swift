//
//  MCPageItem.swift
//  MCPageViewController
//
//  Created by MC on 2018/11/6.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit

public class MCPageItem: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(bgImageView)
        self.addSubview(tagImageView)
        
 
    }
    
    
    override public func layoutSubviews() {
        super.layoutSubviews()

        let selfWidth = self.frame.size.width
        let selfHeight = self.frame.size.height
        
        bgImageView.frame = CGRect.init(x: 0, y: 0, width: selfWidth, height: selfHeight)
        tagImageView.frame = CGRect.init(x: selfWidth - 20, y: 0, width: 20, height: 20)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public lazy var bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.clear
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    

    public lazy var tagImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
}
