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
        self.addSubview(imageView)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        imageView.snp.remakeConstraints { (make) ->Void in
            make.edges.equalTo(self)
        }
    }
    
    public lazy var imageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
}
