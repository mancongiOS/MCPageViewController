//
//  MCCategoryBarCell.swift
//  MCPageViewController_Example
//
//  Created by 满聪 on 2019/6/4.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

public class MCCategoryBarCell: UICollectionViewCell {
    
    
    public var model = MCCategoryBarModel() {
        didSet {
            titleLabel.text = model.title
            
            if model.isSelected {
                titleLabel.textColor = model.selectedColor
                titleLabel.font = model.selectFont
            } else {
                titleLabel.textColor = model.normalColor
                titleLabel.font = model.normalFont
            }
            
            backgroundColor = model.itemBackgroundColor

            
            lineView.isHidden = model.itemSeparatorIsHidden
            lineView.layer.cornerRadius = model.itemSeparatorCornerRadius
            lineView.backgroundColor = model.itemSeparatorBackgroundColor
           
            lineView.snp.remakeConstraints { (make) ->Void in
                make.right.centerY.equalTo(contentView)
                make.width.equalTo(model.itemSeparatorWidth)
                make.height.equalTo(model.itemSeparatorHeight)
            }
            
            
            badgeLabel.isHidden = model.badgeIsHidden
            badgeLabel.backgroundColor = model.badgeBackgroundColor
            
            var badgeSize = CGSize.zero
            
            if model.badgeIsDoc == true {
                badgeSize = CGSize.init(width: 8, height: 8)
                badgeLabel.layer.cornerRadius = 4
            } else {
                
                if let _ = model.badgeValue {
                    badgeLabel.isHidden = false
                } else {
                    badgeLabel.isHidden = true
                }
                
                badgeLabel.textColor = model.badgeTextColor
                badgeLabel.font = model.badgeTextFont
                badgeLabel.text = model.badgeValue
                let height: CGFloat =  model.badgeTextFont.capHeight + 8
                badgeLabel.layer.cornerRadius = height/2

                var width: CGFloat = model.badgeValue?.pgGetWidth(font: model.badgeTextFont, height: height) ?? 0
                
                if width < height {
                    width = height
                } else {
                    width += 6
                }
                
                badgeSize = CGSize.init(width: width, height: height)

            }
                        
            badgeLabel.snp.remakeConstraints { (make) ->Void in
                make.size.equalTo(badgeSize)
                make.centerY.equalTo(titleLabel.snp.top).offset(model.badgeOffset.y)
                make.centerX.equalTo(titleLabel.snp.right).offset(model.badgeOffset.x)
            }
        }
    }
    

    public override func layoutSubviews() {
        super.layoutSubviews()
        
        
        
    }
    

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.remakeConstraints { (make) ->Void in
            make.center.equalTo(contentView)
        }
        
        self.contentView.addSubview(lineView)
        
        self.contentView.addSubview(badgeLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var badgeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = UIColor.red
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.white
        label.layer.masksToBounds = true

        return label
    }()
}

extension String {
    
    fileprivate func pgGetWidth(font:UIFont,height:CGFloat) -> CGFloat {
        let statusLabelText: NSString = self as NSString
        let size = CGSize.init(width: 9999, height: height)
        let dic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key : Any], context: nil).size
        return strSize.width
    }

}
