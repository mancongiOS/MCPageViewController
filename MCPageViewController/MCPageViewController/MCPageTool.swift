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
    func MCPageString_getWidth(font:CGFloat,height:CGFloat) -> CGFloat {
        let statusLabelText: NSString = self as NSString
        let size = CGSize.init(width: 9999, height: height)
        let dic = NSDictionary(object: UIFont.systemFont(ofSize: font), forKey: NSAttributedStringKey.font as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedStringKey : Any], context: nil).size
        return strSize.width
    }
}


public extension UIColor {
    public static let MCPage_gray  = MCPageColor_16(colorStr: "494949")
    public static let MCPage_middleGray  = MCPageColor_16(colorStr: "999999")
    public static let MCPage_light   = MCPageColor_16(colorStr: "f8f8f7")
    public static let MCPage_red  = MCPageColor_16(colorStr: "FF0056")
    
    //返回随机颜色
    public class var randomColor:UIColor {
        get
        {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}


//MARK: -RGB颜色
public func MCPageColor_RGB(r: CGFloat,g: CGFloat,b: CGFloat) -> UIColor {
    if #available(iOS 10.0, *) {
        return UIColor(displayP3Red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
    } else {
        // Fallback on earlier versions
        return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
    }
}

//MARK: -16进制颜色
public func MCPageColor_16(colorStr:String) -> UIColor {
    
    var color = UIColor.red
    var cStr : String = colorStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
    
    if cStr.hasPrefix("#") {
        let index = cStr.index(after: cStr.startIndex)
        cStr = String(cStr.prefix(upTo: index))
    }
    
    if cStr.count != 6 {
        return UIColor.black
    }
    //两种不同截取字符串的方法
    let rIndex = cStr.index(cStr.startIndex, offsetBy: 2)
    let rStr = String(cStr.prefix(upTo: rIndex))
    
    let gRange = cStr.index(cStr.startIndex, offsetBy: 2) ..< cStr.index(cStr.startIndex, offsetBy: 4)
    let gStr = cStr[gRange]
    
    let bIndex = cStr.index(cStr.endIndex, offsetBy: -2)
    let bStr = cStr.suffix(from: bIndex)
    
    color = UIColor.init(red: CGFloat(Float(changeToInt(numStr: rStr)) / 255), green: CGFloat(Float(changeToInt(numStr: String(gStr))) / 255), blue: CGFloat(Float(changeToInt(numStr: String(bStr))) / 255), alpha: 1)
    
    return color
}
private func changeToInt(numStr:String) -> Int {
    
    let str = numStr.uppercased()
    var sum = 0
    for i in str.utf8 {
        //0-9 从48开始
        sum = sum * 16 + Int(i) - 48
        if i >= 65 {
            //A~Z 从65开始，但初始值为10
            sum -= 7
        }
    }
    return sum
}

