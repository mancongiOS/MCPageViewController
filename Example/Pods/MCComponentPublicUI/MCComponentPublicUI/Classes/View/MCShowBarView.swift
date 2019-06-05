//
//  MCShowBarView.swift
//  MCComponentExtension
//
//  Created by MC on 2019/1/15.
//

import Foundation

/**
 * 用来做有一个标题和内容的展示
 * 。
 * 样式 ：
 *
 *  leftLabel的内容                  rightLabel的内容
 *  ——————————————————————————————————————————————
 */
public class MCShowBarView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(leftLabel)
        self.addSubview(rightLabel)
        self.addSubview(lineView)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        leftLabel.snp.remakeConstraints { (make) ->Void in
            make.centerY.equalTo(self)
            make.left.equalTo(0)
        }
        
        rightLabel.snp.remakeConstraints { (make) ->Void in
            make.centerY.equalTo(self)
            make.right.equalTo(0)
        }
        
        lineView.snp.remakeConstraints { (make) ->Void in
            make.height.equalTo(1)
            make.left.right.bottom.equalTo(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.mc15
        label.text = "xxx"
        label.textColor = UIColor.mc_darkGray
        return label
    }()
    
    
    public lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.text = "xxx"
        label.font = UIFont.mc14
        label.textColor = UIColor.mc_gray
        return label
    }()
    
    public lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mc_line
        return view
    }()
}
