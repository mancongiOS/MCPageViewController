//
//  MCTextField.swift
//  MCComponentPublicUI
//
//  Created by MC on 2019/1/14.
//

import Foundation
import MCComponentExtension

/**
 * 输入框
 * 包括下划线。 可以设置隐藏/显示下划线。
 * 可动态设置键盘类型
 */
public enum MCKeyBorardType : Int {
    case Default      // 默认键盘 UIKeyboardTypeDefault
    case asciiCapable // 密码键盘 UIKeyboardTypeASCIICapable
    case URL          // 网址键盘 UIKeyboardTypeURL
    case Number       // 数字键盘 UIKeyboardTypeNumberPad
    case decimal      // 小数键盘 UIKeyboardTypeDecimalPad
    case email        // 邮件键盘 UIKeyboardTypeEmailAddress
}



@objc public protocol MCTextFiledProlocol {
    @objc optional func MCTextFiled_cancel()
    func MCTextFiled_done(text:String)
    @objc optional func MCTextFiled_delete(textField: UITextField)
}

public class MCTextFiled: UITextField {
    
    public var limitCount = 30
    
    public weak var customDelegate : MCTextFiledProlocol?
    
    
    public var keyBoardType = MCKeyBorardType.Default {
        didSet {
            switch keyBoardType {
            case .URL:
                self.keyboardType = UIKeyboardType.URL
            case .asciiCapable:
                self.keyboardType = UIKeyboardType.asciiCapable
            case .Number:
                self.keyboardType = UIKeyboardType.numberPad
            case .decimal:
                self.keyboardType = UIKeyboardType.decimalPad
            case .email:
                self.keyboardType = UIKeyboardType.emailAddress
            default:
                self.keyboardType = UIKeyboardType.default
            }
        }
    }
    
    public var isHiddenLine = true {
        didSet {
            lineView.isHidden = isHiddenLine
        }
    }
    
    // 输入框右侧视图显示的文案
    var rightShowText = "" {
        didSet {
            let strWidth = rightShowText.MCGetWidth(font: 12, height: 14)            
            let label = UILabel()
            label.frame = CGRect.init(x: 0, y: 0, width: strWidth + 5, height: 20)
            label.font = UIFont.systemFont(ofSize: 12)
            label.textColor = UIColor.mc_hex(hex: "999999")
            label.text = rightShowText
            label.textAlignment = NSTextAlignment.right
            self.rightView = label
            self.rightViewMode = UITextField.ViewMode.always
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.font = UIFont.systemFont(ofSize: 14)
        self.textColor = UIColor.mc_hex(hex: "494949")
        self.autocorrectionType = UITextAutocorrectionType.no
        self.placeholder = "请输入"
        delegate = self
        self.autocorrectionType = UITextAutocorrectionType.no
        self.returnKeyType = .done
        
        
        let doneToolbar = UIToolbar()
        //左侧的空隙
        //左侧的空隙
        let cancel: UIBarButtonItem = UIBarButtonItem(title: "取消", style: .done,
                                                      target: self,
                                                      action: #selector(cancelButtonAction))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil, action: nil)
        //右侧的完成按钮
        let done: UIBarButtonItem = UIBarButtonItem(title: "完成", style: .done,
                                                    target: self,
                                                    action: #selector(doneButtonAction))
        
        var items:[UIBarButtonItem] = []
        items.append(cancel)
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
        
        
        self.addSubview(lineView)
    }
    
    
    public override func deleteBackward() {
        super.deleteBackward()
        customDelegate?.MCTextFiled_delete?(textField: self)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()        
        lineView.frame = CGRect.init(x: 0, y: self.frame.height - 1, width: self.frame.width, height: 1)
    }
    
    
    @objc func cancelButtonAction() {
        self.resignFirstResponder()
        customDelegate?.MCTextFiled_cancel?()
    }
    
    @objc func doneButtonAction() {
        self.resignFirstResponder()
        customDelegate?.MCTextFiled_done(text: self.text ?? "")
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mc_hex(hex: "f8f8f7")
        return view
    }()
}

// 对UITextFilde进行扩展， 作用：
extension MCTextFiled : UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else {
            return true
        }
        
        let textLength = text.count + string.count - range.length
        
        return textLength <= limitCount ? true : false
    }
}




extension String {
    /**
     * 计算字符串的宽度
     */
    fileprivate func MCGetWidth(font:CGFloat,height:CGFloat) -> CGFloat {
        let statusLabelText: NSString = self as NSString
        let size = CGSize.init(width: 9999, height: height)
        let dic = NSDictionary(object: UIFont.systemFont(ofSize: font), forKey: NSAttributedString.Key.font as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key : Any], context: nil).size
        return strSize.width
    }
}
