//
//  UIBarButtonItem+Extension.swift
//  MBProgressHUD
//
//  Created by MC on 2018/12/7.
//

import Foundation


extension UIBarButtonItem {
    
    
    /// 添加左右元素项 image
    ///
    /// - Parameters:
    ///   - image: 图片
    ///   - target: 控制器
    ///   - selector: 事件
    ///   - isLeft: 是否左侧导航栏元素项
    /// - Returns: UIBarButtonItem
    public static func mc_setImage(_ image: UIImage?, target: UIViewController, selector: Selector, isLeft: Bool = false) -> UIBarButtonItem {
        
        var barImage = image
        
        if barImage == nil {
            barImage = UIImage.init(named: "...")
        }
        
        var size = CGSize.init(width: 44, height: 44)
        
        if let sizeTemp = barImage?.size {
            size = sizeTemp
        }
        if size.width < 44 { size.width = 44 }
        
        if size.height < 44 { size.height = 44 }
        
        
        let imageView = UIImageView()
        imageView.frame = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        imageView.isUserInteractionEnabled = true
        imageView.image = barImage
        let tap = UITapGestureRecognizer.init(target: target, action: selector)
        imageView.addGestureRecognizer(tap)
        
        
        if isLeft {
            imageView.contentMode = UIView.ContentMode.left
        } else {
            imageView.contentMode = UIView.ContentMode.right
        }
        return UIBarButtonItem.init(customView: imageView)
    }
    
    /// 添加左右元素项 text
    ///
    /// - Parameters:
    ///   - text: 文字
    ///   - textColor: 文字颜色
    ///   - font: 文字大小
    ///   - target: 控制器
    ///   - selector: 事件
    ///   - isLeft: 是否左侧导航栏元素项
    
    /// - Returns: UIBarButtonItem
    public static func mc_setText(_ text: String, textColor: UIColor = UIColor.darkText, font: CGFloat = 14, target: UIViewController, selector: Selector, isLeft : Bool = false) -> UIBarButtonItem {
        
        
        var strWidth = text.getWidth(font: UIFont.systemFont(ofSize: font), height: font + 4)
        
        if strWidth < 44 {
            strWidth = 44
        }
        
        
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect.init(x: 0, y: 0, width: strWidth, height: 44)
        button.addTarget(target, action: selector, for: UIControl.Event.touchUpInside)
        button.adjustsImageWhenHighlighted = false
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: font)
        button.setTitle(text, for: UIControl.State.normal)
        button.setTitleColor(textColor, for: UIControl.State.normal)
        
        if isLeft {
            button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        } else {
            button.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.right
        }
        
        return UIBarButtonItem.init(customView: button)
    }
    
}

/**
 * 计算字符串的宽度  不对外开放
 */
extension String {
    fileprivate func getWidth(font: UIFont, height: CGFloat) -> CGFloat {
        let statusLabelText: NSString = self as NSString
        let size = CGSize.init(width: 9999, height: height)
        let dic = NSDictionary(object: font, forKey: NSAttributedString.Key.font as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key : Any], context: nil).size
        return strSize.width
    }
}
