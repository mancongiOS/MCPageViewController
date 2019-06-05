//
//  UIColor+Extension.swift
//  MCAPI
//
//  Created by MC on 2018/11/26.
//

import Foundation

import UIKit




extension UIColor {
    
    /**
     * RGB颜色 不用除以255
     */
    public static func mc_RGB(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
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
    public class func mc_hex(hex: String, alpha: CGFloat = 1.0) -> UIColor {
        
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



extension UIColor {
    
    /**
     * 通过颜色生成图片
     */
    public func mc_makeImage() -> UIImage {
        let rect = CGRect.init(x: 0.0, y: 0.0, width: 6.0, height: 6.0)
        UIGraphicsBeginImageContext(rect.size)
        let context : CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(self.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}


extension UIColor {
    /// 黑灰色 0x333333
    public static var mc_darkGray: UIColor = UIColor.mc_hex(hex: "0x333333")
    /// 灰色  0x666666
    public static var mc_gray: UIColor = UIColor.mc_hex(hex: "0x666666")
    /// 浅灰色 0x999999
    public static var mc_lightGray: UIColor = UIColor.mc_hex(hex: "0x999999")
    /// 提示文字色 0xCCCCCC
    public static var mc_prompt: UIColor = UIColor.mc_hex(hex: "0xCCCCCC")
    /// 分割线 0xEEEEEE 所有的tablView,collectionView的分割线
    public static var mc_line: UIColor = UIColor.mc_hex(hex: "0xEEEEEE")
    /// 背景色 0xF5F5F5
    public static var mc_backgroud: UIColor = UIColor.mc_hex(hex: "0xF5F5F5")
}




/// 渐变色
extension CAGradientLayer {
    
    /// 渐变方向
    public enum CAGradientDirection {
        case vertical
        case horizontal
    }
    
    /**
     * 使用说明 一定先要设置frame
     let gradientLayer = CAGradientLayer()
     gradientLayer.frame = CGRect.init(x: 0, y: 0, width: 200, height: 30)
     let cgColors = [UIColor.white.cgColor,UIColor.red.cgColor]
     gradientLayer = gradientLayer.jkMakeLayer(cgColors: cgColors, direction: .horizontal)
     self.layer.insertSublayer(gradientLayer, at: 0)
     */
    
    /**
     * 参数说明
     * cgColors CGColor类型数组
     * direction CAGradientDirection枚举，表示颜色渐变方向
     * locations 每个颜色对应的位置，区间在[0-1]之间.比如三种颜色的集合[A,B,C],设置的区间为[0, 0.2, 1]
     那么A和B均分前0~0.2区间的位置颜色，B和C均分[0.2~1]区间的位置颜色
     */
    public func mc_makeLayer(colors: [UIColor], direction: CAGradientDirection = .horizontal, locations: [NSNumber] = []) {
        
        
        let cgColors = colors.map {
            $0.cgColor
        }
        
        
        var gradientLocations:[NSNumber] = locations
        
        if locations.isEmpty {
            let arrayM = NSMutableArray()
            let spacing = 1 / Double((cgColors.count - 1))
            
            for i in 0..<cgColors.count {
                let location = Double(i) * spacing
                arrayM.add(NSNumber.init(value: location))
            }
            gradientLocations = arrayM as! [NSNumber]
        }
        
        
        
        //创建CAGradientLayer对象并设置参数
        self.colors = cgColors
        self.locations = gradientLocations
        
        //设置渲染的起始结束位置（横向渐变）
        if direction == .horizontal {
            self.startPoint = CGPoint(x: 0, y: 0)
            self.endPoint = CGPoint(x: 1, y: 0)
        } else {
            self.startPoint = CGPoint(x: 0, y: 0)
            self.endPoint = CGPoint(x: 0, y: 1)
        }
    }
}

