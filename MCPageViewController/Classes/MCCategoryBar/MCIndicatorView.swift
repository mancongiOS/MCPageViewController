//
//  MCIndicatorView.swift
//  Alamofire
//
//  Created by 满聪 on 2019/6/3.
//

import UIKit
import Foundation


open class MCIndicatorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let indicator = MCPageConfig.shared.indicator
        
        isHidden = indicator.isHiddenIndicator
        layer.cornerRadius = indicator.cornerRadius
        layer.masksToBounds = true
        backgroundColor = indicator.backgroundColor
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
