//
//  MCTableViewCell.swift
//  MCComponentExtension
//
//  Created by MC on 2019/1/15.
//

import Foundation


import UIKit
import SnapKit
import MCComponentExtension

open class MCTableViewCell: UITableViewCell {
    
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.backgroundColor = UIColor.white
        
        
        self.addSubview(lineView)
        lineView.snp.remakeConstraints { (make) ->Void in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(1)
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mc_line
        return view
    }()
}
