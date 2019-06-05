//
//  String+Extension.swift
//  MCAPI
//
//  Created by MC on 2018/11/26.
//

import Foundation



import UIKit
import CommonCrypto

//MARK: 类型转换
extension String {
    
    /**
     * 字符串 转 Int
     */
    public var intValue: Int {
        let str = self
        return Int(str) ?? 0
    }
    
    /**
     * 字符串 转 Float
     */
    public var floatValue: Float {
        let str = self
        return Float(str) ?? 0
    }
    
    /**
     * 字符串 转 Double
     */
    public var doubleValue: Double {
        let str = self
        return Double(str) ?? 0
    }
    
    /**
     * 字符串 转 Number
     */
    public var numberValue: NSNumber {
        let str = self
        let value = Int(str) ?? 0
        return NSNumber.init(value: value)
    }
}



extension String {
    
    /**
     * 判断是否电话号码 11位并且首位是1
     */
    public func mc_isPhoneNumber(str:String) -> Bool {
        if str.count != 11 { return false }
        if str.first != "1" { return false }
        return true
    }
    
    
    /**
     * 校验密码强度
     * 必须包含字母和数字，长度必须大于等于6
     */
    public func mc_isPassword() -> Bool {
        
        if self.count <= 5 {
            return false
        }
        
        let numberRegex:NSPredicate = NSPredicate(format:"SELF MATCHES %@","^.*[0-9]+.*$")
        let letterRegex:NSPredicate = NSPredicate(format:"SELF MATCHES %@","^.*[A-Za-z]+.*$")
        if numberRegex.evaluate(with: self) && letterRegex.evaluate(with: self) {
            return true
        } else {
            return false
        }
    }
    
}




extension String {
    
    /**
     * 计算字符串的高度
     */
    public func mc_getHeight(font: CGFloat, width: CGFloat) -> CGFloat {
        return mc_getHeight(font: UIFont.systemFont(ofSize: font), width: width)
    }
    
    public func mc_getHeight(font: UIFont, width: CGFloat) -> CGFloat {
        let statusLabelText: NSString = self as NSString
        let size = CGSize.init(width: width, height: 9000)
        let dic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key : Any], context: nil).size
        return strSize.height
    }
    
    /**
     * 计算字符串的宽度
     */
    public func mc_getWidth(font: CGFloat, height: CGFloat) -> CGFloat {
        return mc_getWidth(font: UIFont.systemFont(ofSize: font), height: height)
    }
    public func mc_getWidth(font:UIFont,height:CGFloat) -> CGFloat {
        let statusLabelText: NSString = self as NSString
        let size = CGSize.init(width: 9999, height: height)
        let dic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key : Any], context: nil).size
        return strSize.width
    }
    
    
    /**
     * 截取指定的区间
     */
    public func mc_clip(range: (location: Int, length: Int)) -> String {
        
        if range.location + range.length >= self.count {
            return self
        }
        let locationIndex = self.index(startIndex, offsetBy: range.location)
        let range = locationIndex..<self.index(locationIndex, offsetBy: range.length)
        return String(self[range])
    }
    
    
    /**
     * 字符串的截取 从头截取到指定index
     */
    public func mc_clipFromPrefix(to index: Int) -> String {
        
        if self.count <= index {
            return self
        } else {
            let index = self.index(self.startIndex, offsetBy: index)
            let str = self.prefix(upTo: index)
            return String(str)
        }
    }
    /**
     * 字符串的截取 从指定位置截取到尾部
     */
    public func mc_cutToSuffix(from index: Int) -> String {
        if self.count <= index {
            return self
        } else {
            let selfIndex = self.index(self.startIndex, offsetBy: index)
            let str = self.suffix(from: selfIndex)
            return String(str)
        }
    }
}



extension String {
    
    /**
     * 设置文本的颜色
     */
    public func mc_setMutableColor(_ color: UIColor,range: NSRange) -> NSAttributedString {
        let attributedString = NSMutableAttributedString.init(string: self)
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        return attributedString
    }
    /**
     * 设置文本的字体大小
     */
    public func mc_setMutableFont(_ font: CGFloat, range: NSRange) -> NSAttributedString {
        let attributedString = NSMutableAttributedString.init(string: self)
        attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: font), range: range)
        return attributedString
    }
    
    /**
     * 设置文本的字体大小和颜色
     */
    public func mc_setMutableFontAndColor(font: CGFloat,
                                          fontRange: NSRange,
                                          color: UIColor,
                                          colorRange: NSRange)
        -> NSAttributedString {
            let attributedString = NSMutableAttributedString.init(string: self)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: colorRange)
            
            attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: font), range: fontRange)
            return attributedString
    }
    
    /**
     * 设置删除线 NSStrikethroughStyleAttributeName
     */
    public func mc_setDeleteLine() -> NSAttributedString {
        let range = NSMakeRange(0, self.count)
        let attributedString = NSMutableAttributedString.init(string: self)
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: range)
        return attributedString
    }
    
    /**
     * 同时设置设置删除线和字体大小
     */
    public func mc_setMutableFontAndDeleteLine(_ font: CGFloat,range: NSRange) -> NSAttributedString {
        let attributedString = NSMutableAttributedString.init(string: self)
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: range)
        
        let deleTeRange = NSMakeRange(0, self.count)
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: deleTeRange)
        
        return attributedString
    }
    
    
    /**
     * 设置文本的行间距
     */
    public func mc_setLineSpace(lineSpace: CGFloat) -> NSAttributedString {
        let attributedString = NSMutableAttributedString.init(string: self)
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineSpacing = lineSpace
        let range = NSRange.init(location: 0, length: self.count)
        attributedString.addAttributes([NSAttributedString.Key.paragraphStyle:paragraphStyle], range: range)
        
        return attributedString
    }
    
    
    
    
    /**
     * 设置图文详情
     */
    public func mc_setTextAttachment(image: UIImage, imageFrame: CGRect) -> NSMutableAttributedString {
        
        let attributedStrM : NSMutableAttributedString = NSMutableAttributedString()
        let nameStr : NSAttributedString = NSAttributedString(string: " " + self, attributes: nil)
        
        let attachment = NSTextAttachment.init()
        attachment.image = image
        attachment.bounds = imageFrame
        
        attributedStrM.append(NSAttributedString(attachment: attachment))
        attributedStrM.append(nameStr)
        return attributedStrM
    }
}


extension String {
    
    
    /**
     * 字符串转字典
     */
    public func mc_transformToDictionary() -> NSDictionary {
        let jsonData:Data = self.data(using: .utf8)!
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
    }
    
    
    /**
     * MD5加密
     * 需要在桥接文件中引入 <CommonCrypto/CommonDigest.h>
     */
    public func mc_md5() -> String {
        let str = self.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!, strLen, result)
        let hash = NSMutableString()
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize(count: 0)
        
        return String(format: hash as String)
    }
}



extension String {
    
    /**
     * 生成二维码图片
     * logoImage 中间的图片logo
     */
    public func mc_makeQRImage(_ logoImage: UIImage? = nil) -> UIImage? {
        
        let qrString = self
        
        let stringData = qrString.data(using: String.Encoding.utf8, allowLossyConversion: false)
        //创建一个二维码的滤镜
        let qrFilter = CIFilter(name: "CIQRCodeGenerator")
        qrFilter?.setValue(stringData, forKey: "inputMessage")
        qrFilter?.setValue("H", forKey: "inputCorrectionLevel")
        let qrCIImage = qrFilter?.outputImage
        
        // 创建一个颜色滤镜,黑白色
        let colorFilter = CIFilter(name: "CIFalseColor")!
        colorFilter.setDefaults()
        colorFilter.setValue(qrCIImage, forKey: "inputImage")
        colorFilter.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: "inputColor0")
        colorFilter.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor1")
        // 返回二维码image
        let codeImage = UIImage(ciImage: (colorFilter.outputImage!.transformed(by: CGAffineTransform(scaleX: 5, y: 5))))
        
        // 中间一般放logo
        if logoImage != nil {
            let whiteImage = UIColor.white.makeImage()
            let whiteWaterImage = codeImage.addWatermark(image: whiteImage, scale: 4.1)
            let waterImage = whiteWaterImage.addWatermark(image: logoImage!, scale: 5)
            return waterImage
        }
        return codeImage
        
    }
}











// 以下为上面对外方法提供服务
extension UIColor {
    
    /**
     * 通过颜色生成图片
     */
    fileprivate func makeImage() -> UIImage {
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

extension UIImage {
    /**
     * 给图片添加水印图片
     */
    fileprivate func addWatermark(image: UIImage,scale: CGFloat) -> UIImage {
        UIGraphicsBeginImageContext(self.size)
        
        self.draw(in: CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height))
        
        let waterWH = self.size.width / scale
        let waterX = (self.size.width - waterWH) / 2
        let waterH = (self.size.height - waterWH) / 2
        
        image.draw(in: CGRect.init(x: waterX, y: waterH, width: waterWH, height: waterWH))
        UIGraphicsEndPDFContext()
        let imageNew = UIGraphicsGetImageFromCurrentImageContext()
        return imageNew!
    }
}
