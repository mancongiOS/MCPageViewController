//
//  MCCategoryBarCell.swift
//  MCPageViewController_Example
//
//  Created by 满聪 on 2019/6/4.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

public class MCCategoryBarCell: UICollectionViewCell {
    
    public var isCategorySelected: Bool = false {
        didSet {
            
            let category = MCPageConfig.shared.category
            
            if isCategorySelected {
                titleLabel.textColor = category.selectedColor
                titleLabel.font = category.selectFont
            } else {
                titleLabel.textColor = category.normalColor
                titleLabel.font = category.normalFont
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        backgroundColor = MCPageConfig.shared.category.itemBackgroundColor
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.remakeConstraints { (make) ->Void in
            make.edges.equalTo(self.contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
}
