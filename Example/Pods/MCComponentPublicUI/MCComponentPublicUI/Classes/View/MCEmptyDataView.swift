//
//  MCEmptyDataView.swift
//  MCComponentPublicUI
//
//  Created by MC on 2019/1/14.
//

import UIKit
import SnapKit
import MCComponentExtension

/**
 * 空数据页面
 */
public class MCEmptyDataView: UIView {
    
    public var emptyClosure: (() -> Void)?
    
    public var imageTopMargin: CGFloat = 150
    public var textTopMargin: CGFloat = 20
    public var buttonTopMargin: CGFloat = 40
    public var buttonSize: CGSize = CGSize.init(width: 240, height: 40)

    public var isShowButton : Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(emptyImageView)
        self.addSubview(emptyTextLabel)
        self.addSubview(emptyButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        
        
        emptyImageView.snp.remakeConstraints { (make) ->Void in
            make.centerX.equalTo(self)
            make.top.equalTo(imageTopMargin)
        }
        
        emptyTextLabel.snp.remakeConstraints { (make) ->Void in
            make.centerX.equalTo(self)
            make.top.equalTo(emptyImageView.snp.bottom).offset(textTopMargin)
        }
        
        emptyButton.snp.remakeConstraints { (make) ->Void in
            make.centerX.equalTo(self)
            make.top.equalTo(emptyTextLabel.snp.bottom).offset(buttonTopMargin)
            make.size.equalTo(buttonSize)
        }
        
        emptyButton.isHidden = !isShowButton
    }
    
    @objc private func emptyButtonEvent() {
        emptyClosure?()
    }
    
    
    public lazy var emptyImageView: UIImageView = {
        let iv = UIImageView.init()
        let image1 = Bundle.mc_loadImage("EmptyData", from: "MCComponentPublicUIViewBundle", in: "MCComponentPublicUI")
        iv.image = image1
        return iv
    }()
    
    public lazy var emptyTextLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.gray
        label.text = "暂无数据"
        return label
    }()
    
    public lazy var emptyButton: UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor.groupTableViewBackground
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitle("返回", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(emptyButtonEvent), for: .touchUpInside)
        return button
    }()
}
