//
//  JKToastHelper.swift
//  GMJKExtension
//
//  Created by 满聪 on 2019/4/19.
//

import Foundation
import UIKit


extension String {
    
    func getWidth(font:CGFloat,height:CGFloat) -> CGFloat {
        let statusLabelText: NSString = self as NSString
        let size = CGSize.init(width: 9999, height: height)
        let dic = NSDictionary(object: UIFont.systemFont(ofSize: font), forKey: NSAttributedString.Key.font as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key : Any], context: nil).size
        return strSize.width
    }
}
