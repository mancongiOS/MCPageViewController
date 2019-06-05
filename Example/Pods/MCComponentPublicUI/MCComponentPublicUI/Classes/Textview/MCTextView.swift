//
//  MCTextView.swift
//  WisdomSpace
//
//  Created by goulela on 2017/9/18.
//  Copyright © 2017年 MC. All rights reserved.
//

import UIKit


/**
 * 继续完善
 * 点击完成按钮的回调
 * 根据行高自动增高
 */

public enum MCReturnKeyType {
    case done      // 完成按钮，点击收起键盘
    case newline   // 换行按钮，点击换行处理
}

public class MCTextView: UIView {
    
    
    /**
     * limitCount
     * 小于等于0的时候，不做任何字数限制
     * 大于0的时候，对字数进行限制
     */
    public var limitCount = 0 {
        didSet {
            if limitCount <= 0 {
                limitCountLabel.isHidden = true
            } else {
                limitCountLabel.isHidden = false
                limitCountLabel.text = "0/\(limitCount)"
            }
        }
    }
    
    public var placeholder = "" {
        didSet {
            placeholderLabel.text = placeholder
        }
    }
    
    
    public var text = "" {
        didSet {
            textView.text = text
            
            if text.isEmpty {
                placeholderLabel.isHidden = false
                limitCountLabel.text = "0/\(limitCount)"
                
            } else {
                placeholderLabel.isHidden = true
                limitCountLabel.text = "\(text.count)/\(limitCount)"
            }
            
        }
    }
    
    
    public var font : UIFont = UIFont.systemFont(ofSize: 15) {
        didSet {
            textView.font = font
            placeholderLabel.font = font
        }
    }
    
    
    /**
     * returnKeyType
     * 右下角按钮，是换行还是确定
     */
    public var returnKeyType : MCReturnKeyType? = MCReturnKeyType.newline {
        didSet {
            
            
            if returnKeyType == MCReturnKeyType.done {
                textView.returnKeyType = UIReturnKeyType.done
            } else {
                textView.returnKeyType = UIReturnKeyType.default
            }
        }
    }
        
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(placeholderLabel)
        self.addSubview(limitCountLabel)
        self.addSubview(textView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.placeholderLabel.font = textView.font
        
        
        textView.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        
        
        placeholderLabel.frame = CGRect.init(x: 5, y: 5, width: 0, height: 0)
        placeholderLabel.sizeToFit()
        
        
        let width = self.frame.size.width
        let height = self.frame.size.height
        
        let size = CGSize.init(width: 60, height: 12)
        
        
        limitCountLabel.frame = CGRect.init(x: width - size.width - 5, y: height - size.height - 5, width: size.width, height: size.height)
        
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
    
    // 字符串的截取 从头截取到指定index
    func MCString_prefix(index:Int,text:String) -> String {
        if text.count <= index {
            return text
        } else {
            let index = text.index(text.startIndex, offsetBy: index)
            let str = text.prefix(upTo: index)
            return String(str)
        }
    }
    
    
    
    // MARK: 懒加载
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "请输入"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.MCHex("CACACC")
        return label
    }()
    
    private lazy var textView: UITextView = {
        let view = UITextView()
        view.delegate = self
        view.font = UIFont.systemFont(ofSize: 14)
        view.backgroundColor = UIColor.clear
        view.autocorrectionType = UITextAutocorrectionType.no  // 取消联想功能
        return view
    }()
    
    private lazy var limitCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0/\(limitCount)"
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.init(red: 216/255.0, green: 215/255.0, blue: 216/255.0, alpha: 1)
        label.textAlignment = NSTextAlignment.right
        return label
    }()
    
}


extension MCTextView : UITextViewDelegate {
    
    public func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > limitCount {
            
            //获得已输出字数与正输入字母数
            let selectRange = textView.markedTextRange
            
            //获取高亮部分 － 如果有联想词则解包成功
            if let selectRange = selectRange {
                let position =  textView.position(from: (selectRange.start), offset: 0)
                if (position != nil) {
                    return
                }
            }
            
            let textContent = textView.text ?? ""
            let textNum = textContent.count
            
            //截取
            if textNum > limitCount && limitCount > 0 {
                textView.text = MCString_prefix(index: limitCount, text: textContent)
            }
        }
        text = textView.text
        self.limitCountLabel.text =  "\(textView.text.count)/\(limitCount)"
    }
    
    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.placeholderLabel.isHidden = true
        return true
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            self.placeholderLabel.isHidden = false
        } else {
            self.placeholderLabel.isHidden = true
        }
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if returnKeyType == MCReturnKeyType.done {
            if text == "\n"{
                textView.resignFirstResponder()
            }
            
            return true
        }
        return true
    }
}


extension UIColor {
    /**
     * 16进制的生成颜色
     */
    fileprivate class func MCHex(_ hex: String, _ alpha: CGFloat = 1.0) -> UIColor {
        if hex.isEmpty {
            return UIColor.clear
        }
        
        /** 传进来的值。 去掉了可能包含的空格、特殊字符， 并且全部转换为大写 */
        var hHex = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        /** 如果处理过后的字符串少于6位 */
        if hHex.count < 6 {
            return UIColor.clear
        }
        /** 开头是用0x开始的 */
        if hHex.hasPrefix("0X") {
            hHex = (hHex as NSString).substring(from: 2)
        }
        /** 开头是以＃开头的 */
        if hHex.hasPrefix("#") {
            hHex = (hHex as NSString).substring(from: 1)
        }
        /** 开头是以＃＃开始的 */
        if hHex.hasPrefix("##") {
            hHex = (hHex as NSString).substring(from: 2)
        }
        /** 截取出来的有效长度是6位， 所以不是6位的直接返回 */
        if hHex.count != 6 {
            return UIColor.clear
        }
        
        /** R G B */
        var range = NSMakeRange(0, 2)
        
        /** R */
        let rHex = (hHex as NSString).substring(with: range)
        
        /** G */
        range.location = 2
        let gHex = (hHex as NSString).substring(with: range)
        
        /** B */
        range.location = 4
        let bHex = (hHex as NSString).substring(with: range)
        
        /** 类型转换 */
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        
        Scanner(string: rHex).scanHexInt32(&r)
        Scanner(string: gHex).scanHexInt32(&g)
        Scanner(string: bHex).scanHexInt32(&b)
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
}
