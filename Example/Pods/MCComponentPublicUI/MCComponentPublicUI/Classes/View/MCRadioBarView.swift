//
//  MCRadioBarView.swift
//  MCComponentExtension
//
//  Created by MC on 2019/1/15.
//

import Foundation

public class MCRadioBarView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        
        self.addSubview(lineView)
        
        self.addSubview(leftLabel)
        
        
        self.addSubview(statusButton)
        
        self.addSubview(rightLabel)
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
        
        
        statusButton.snp.remakeConstraints { (make) ->Void in
            make.edges.equalTo(self)
        }

        
        var imageWidth : CGFloat = statusButton.currentImage?.size.width ?? 0
        
        imageWidth += 10
        rightLabel.snp.remakeConstraints { (make) ->Void in
            make.left.equalTo(leftLabel.snp.right)
            make.right.equalTo(-imageWidth)
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
    
    public lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.mc14
        label.textColor = UIColor.mc_gray
        label.textAlignment = .right
        return label
    }()
    
    public lazy var statusButton: UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        
        let image1 = Bundle.mc_loadImage("notSelected", from: "MCComponentPublicUIViewBundle", in: "MCComponentPublicUI")
        let image2 = Bundle.mc_loadImage("selected", from: "MCComponentPublicUIViewBundle", in: "MCComponentPublicUI")

        
        
        button.setImage(image1, for: .normal)
        button.setImage(image2, for: .selected)
        button.contentHorizontalAlignment = .right
        
        return button
    }()
}
