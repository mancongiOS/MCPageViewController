//
//  UITextView+Extension.swift
//  MCComponentExtension
//
//  Created by 满聪 on 2019/6/25.
//

import Foundation

extension UITextView {
    //（链接为空时则表示普通文本）
    
    /// 添加链接文本
    ///
    /// - Parameters:
    ///   - string: 显示的文字内容
    ///   - withURLString: 链接 为空时则表示普通文本
    ///   - stringColor: 文字颜色
    ///   - underlineColor: 下划线的颜色
    public func appendLinkString(_ string: String,
                                 withURLString: String = "",
                                 isShowUnderline: Bool = false,
                                 underlineColor: UIColor? = nil) {
        //原来的文本内容
        let attrString:NSMutableAttributedString = NSMutableAttributedString()
        attrString.append(self.attributedText)
        
        //新增的文本内容（使用默认设置的字体样式）
        let attrs = [NSAttributedString.Key.font : self.font!]
        let appendString = NSMutableAttributedString(string: string, attributes:attrs)
        //判断是否是链接文字
        if withURLString != "" {
            let range:NSRange = NSMakeRange(0, appendString.length)
            appendString.beginEditing()
            appendString.addAttribute(NSAttributedString.Key.link, value:withURLString, range:range)
            
            
            if isShowUnderline {
                appendString.addAttribute(NSAttributedString.Key.underlineStyle, value:NSUnderlineStyle.single.rawValue, range:range)

                if let color = underlineColor {
                    appendString.addAttribute(NSAttributedString.Key.underlineColor, value:color, range:range)
                }
            }
            

            appendString.endEditing()
        }
        //合并新的文本
        attrString.append(appendString)
        
        //设置合并后的文本
        self.attributedText = attrString
    }
}

