//
//  MCEventBarView.swift
//  MCComponentExtension
//
//  Created by MC on 2019/1/15.
//

import Foundation
import SnapKit

public class MCEventBarView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        self.addSubview(lineView)
        
        self.addSubview(leftLabel)
        
        self.addSubview(arrowImageView)
        
        self.addSubview(rightButton)
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
        
        arrowImageView.snp.remakeConstraints { (make) ->Void in
            make.centerY.equalTo(self)
            make.size.equalTo(CGSize.init(width: 8, height: 14))
            make.right.equalTo(0)
        }
        
        rightButton.snp.remakeConstraints { (make) ->Void in
            make.left.equalTo(leftLabel.snp.right)
            make.right.equalTo(arrowImageView.snp.left).offset(-10)
            make.top.bottom.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mc_line
        return view
    }()
    
    public lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        let image1 = Bundle.mc_loadImage("arrow", from: "MCComponentPublicUIViewBundle", in: "MCComponentPublicUI")
        imageView.image = image1
        return imageView
    }()
    
    public lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.mc14
        label.textColor = UIColor.mc_darkGray
        return label
    }()
    
    public lazy var rightButton: UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.titleLabel?.font = UIFont.mc14
        button.setTitle("请选择", for: .normal)
        button.setTitleColor(UIColor.mc_gray, for: .normal)
        button.setTitleColor(UIColor.mc_darkGray, for: .selected)
        button.contentHorizontalAlignment = .right
        button.titleLabel?.lineBreakMode = .byTruncatingTail
        return button
    }()
}
