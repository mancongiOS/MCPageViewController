//
//  MCInputBarView.swift
//  MCComponentExtension
//
//  Created by MC on 2019/1/15.
//

import Foundation
import UIKit

public class MCInputBarView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        self.addSubview(lineView)
        
        self.addSubview(leftLabel)
        
        self.addSubview(rightTextFiled)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        lineView.snp.remakeConstraints { (make) ->Void in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(1)
        }
        
        leftLabel.snp.remakeConstraints { (make) ->Void in
            make.left.equalTo(0)
            make.centerY.equalTo(self)
            make.width.equalTo(100)
        }
        
        rightTextFiled.snp.remakeConstraints { (make) ->Void in
            make.left.equalTo(leftLabel.snp.right)
            make.right.equalTo(0)
            make.top.bottom.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mc_line
        return view
    }()
    
    public lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.mc14
        label.textColor = UIColor.mc_darkGray
        return label
    }()
    
    
    public lazy var rightTextFiled: UITextField = {
        let tf = UITextField()
        tf.placeholder = "请填写"
        tf.font = UIFont.mc14
        tf.textColor = UIColor.mc_gray
        tf.textAlignment = .right
        return tf
    }()
}
