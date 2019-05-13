//
//  MCPageTool.swift
//  MCPageViewController
//
//  Created by MC on 2018/11/5.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit

public extension String {
    // 计算字符串的宽度
    public func getWidth(font:UIFont,height:CGFloat) -> CGFloat {
        
        let size: CGSize = self.size(withAttributes: [NSAttributedString.Key.font: font])
        
        

        
//        let statusLabelText: NSString = self as NSString
//        let size = CGSize.init(width: 9999, height: height)
//        let dic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
//        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key : Any], context: nil).size
        return size.width
    }
}



extension UIColor {
    
    public static let MCPage_gray  = UIColor.MCHex(hex: "666666")
    public static let MCPage_red  = UIColor.red
    public static let MCPage_line  = UIColor.MCHex(hex: "EEEEEE")

    
    
    /**
     * RGB颜色 不用除以255
     */
    public static func MCRGB(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        if #available(iOS 10.0, *) {
            return UIColor(displayP3Red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
        } else {
            // Fallback on earlier versions
            return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
        }
    }
    
    
    
    /**
     * #ff00000000 此为16进制颜色代码
     * 前两位ff为透明度，后六位为颜色值（000000为黑色，ffffff为白色，可以用ps等软件获取）
     * 透明度分为256阶（0~255），计算机上16进制表示为（00~ff）,透明度为0阶，不透明度为255阶，如果50%透明度就是127阶（256的一半当然是128，但是因为从0开始，所以实际上是127）
     * 如果是6位，默认是不透明。
     */
    public class func MCHex(hex: String, alpha: CGFloat = 1.0) -> UIColor {
        
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = alpha
        var hex:   String = hex
        
        
        
        /** 开头是用0x开始的 */
        if hex.hasPrefix("0X") {
            let index = hex.index(hex.startIndex, offsetBy: 2)
            hex = String(hex[index...])
        }
        if hex.hasPrefix("0x") {
            let index = hex.index(hex.startIndex, offsetBy: 2)
            hex = String(hex[index...])
        }
        /** 开头是以＃开头的 */
        if hex.hasPrefix("#") {
            let index = hex.index(hex.startIndex, offsetBy: 1)
            hex = String(hex[index...])
        }
        /** 开头是以＃＃开始的 */
        if hex.hasPrefix("##") {
            let index = hex.index(hex.startIndex, offsetBy: 2)
            hex = String(hex[index...])
        }
        
        
        let scanner = Scanner(string: hex)
        var hexValue: CUnsignedLongLong = 0
        if scanner.scanHexInt64(&hexValue) {
            switch (hex.count) {
            case 3:
                red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                blue  = CGFloat(hexValue & 0x00F)              / 15.0
            case 4:
                red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                alpha = CGFloat(hexValue & 0x000F)             / 15.0
            case 6:
                red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
            case 8:
                red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
            default:
                print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8", terminator: "")
            }
        } else {
            print("Scan hex error")
            return UIColor.white
        }
        return self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}


extension String {
    /**
     * 字符串的截取 从头截取到指定index
     */
    public func MCClipFromPrefix(to index: Int) -> String {
        
        if self.count <= index {
            return self
        } else {
            let index = self.index(self.startIndex, offsetBy: index)
            let str = self.prefix(upTo: index)
            return String(str)
        }
    }

}
