//
//  MCUpAndDownTextButton.swift
//  MCComponentExtension
//
//  Created by MC on 2019/1/25.
//

import Foundation

import MCComponentExtension
import SnapKit

public class MCTopAndBottomTextButton: UIButton {
    
    override public func draw(_ rect: CGRect) {
        
        self.addSubview(topLabel)
        topLabel.snp.remakeConstraints { (make) ->Void in
            make.left.right.equalTo(self)
            make.bottom.equalTo(self.snp.centerY).offset(-2)
        }
        
        self.addSubview(bottomLabel)
        bottomLabel.snp.remakeConstraints { (make) ->Void in
            make.left.right.equalTo(self)
            make.top.equalTo(self.snp.centerY).offset(3)
        }
    }
    
    
    public lazy var topLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.mc13
        label.textColor = UIColor.mc_darkGray
        label.text = "Up"
        label.textAlignment = .center
        return label
    }()
    
    public lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.mc12
        label.textColor = UIColor.mc_gray
        label.text = "bottom"
        label.textAlignment = .center
        return label
    }()
    
}
