//
//  MCPageItem.swift
//  MCPageViewController
//
//  Created by MC on 2018/11/6.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit
import SDWebImage


/// tagImageView 和 bgImageView可以支持设置gif图片。要关联SDWebImage和FL
open class MCPageItem: UIButton {

    public var tagSize = CGSize.init(width: 20, height: 20)
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(bgImageView)
        self.addSubview(tagImageView)
    }
    
    
    override open func layoutSubviews() {
        super.layoutSubviews()

        let selfWidth = self.frame.size.width
        let selfHeight = self.frame.size.height
        
        
        let title_x = self.titleLabel?.frame.maxX ?? 0
        
        
        bgImageView.frame = CGRect.init(x: 0, y: 0, width: selfWidth, height: selfHeight)
        tagImageView.frame = CGRect.init(x: title_x - 2, y: 0, width: tagSize.width, height: tagSize.height)
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
    

    public lazy var tagImageView: FLAnimatedImageView = {
        let imageView = FLAnimatedImageView()
        return imageView
    }()
}
