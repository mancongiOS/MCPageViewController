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
    
    public var emptyClosure : (() -> Void)?
    
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
            make.centerY.equalTo(self.snp.centerY).offset(-60)
        }
        
        if isShowButton {
            emptyButton.snp.remakeConstraints { (make) ->Void in
                make.centerX.equalTo(self)
                make.top.equalTo(emptyImageView.snp.bottom).offset(40)
                make.height.equalTo(40)
                make.width.equalTo(self.snp.width).multipliedBy(0.65)
            }
        } else {
            emptyTextLabel.snp.remakeConstraints { (make) ->Void in
                make.centerX.equalTo(self)
                make.top.equalTo(emptyImageView.snp.bottom).offset(30)
                make.height.equalTo(40)
            }
        }
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
        button.backgroundColor = UIColor.red
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitle("返回", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(emptyButtonEvent), for: .touchUpInside)
        return button
    }()
}
