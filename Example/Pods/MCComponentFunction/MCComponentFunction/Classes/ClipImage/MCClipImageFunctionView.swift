//
//  MCClipImageFunctionView.swift
//  MCAPI
//
//  Created by MC on 2018/9/27.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit

import MCComponentExtension
/**
 * 底部功能区域，包括:
 * 1. 取消按钮
 * 2. 旋转图片按钮
 * 3. 重新选择尺寸比例按钮
 * 4. 确定选择按钮
 */


public class MCClipImageFunctionView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(cancelButton)
        self.addSubview(sureButton)
        self.addSubview(rotatingButton)
        
        

    }
    
    
    public override func layoutSubviews() {
        super.layoutSubviews()

        let selfWidth = self.frame.size.width
        let selfHeight = self.frame.size.height
        
        let iconWH : CGFloat = 25
        
        
        let y = (selfHeight - iconWH) / 2
        cancelButton.frame = CGRect.init(x: 20, y: y, width: iconWH, height: iconWH)
        sureButton.frame = CGRect.init(x: selfWidth - 20 - 30, y: y, width: 25, height: 25)
        rotatingButton.frame = CGRect.init(x: selfWidth/2 - 15, y: y, width: iconWH, height: iconWH)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var cancelButton: UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        
        let image = Bundle.mc_loadImage("ClipImage_cancel", from: "MCClipImageBundle", in: "MCComponentFunction")
        button.setImage(image, for: .normal)
        return button
    }()
    
    lazy var rotatingButton: UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        let image = Bundle.mc_loadImage("ClipImage_rotating", from: "MCClipImageBundle", in: "MCComponentFunction")
        button.setImage(image, for: .normal)
        
        return button
    }()
    
    
    lazy var sureButton: UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        let image = Bundle.mc_loadImage("ClipImage_sure", from: "MCClipImageBundle", in: "MCComponentFunction")
        button.setImage(image, for: .normal)
        return button
    }()
    
}
