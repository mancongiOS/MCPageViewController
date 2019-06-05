//
//  Button+Extension.swift
//  MCComponentPublicUI
//
//  Created by MC on 2019/1/14.
//

import Foundation


public enum MCButtonContentDirection {
    /// 图文水平排列，图左 文右
    case horizontal
    /// 图文水平排列，文左，图右
    case horizontalReverse
    /// 图文垂直排列，图上，文下
    case vertical
    /// 图文垂直排列，文上，图下
    case verticalReverse
}

public protocol MCButtonDirectionRrotocol {
    func directionFunc(direction: MCButtonContentDirection,margin : CGFloat)
}

extension UIButton: MCButtonDirectionRrotocol {
    /// 设置按钮的图文位置
    ///
    /// - Parameters:
    ///   - direction: 图文的方向
    ///   - margin: 图文的间隔
    public func directionFunc(direction: MCButtonContentDirection,margin : CGFloat) {
        
        let imageSize = self.imageView?.frame.size ?? CGSize.zero
        let titleSize = self.titleLabel?.frame.size ?? CGSize.zero
        
        
        switch direction {
        case .horizontal:
            self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: -margin)
            self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -margin, bottom: 0, right: 0)
            break
        case .horizontalReverse:
            self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -imageSize.width-margin, bottom: 0, right: imageSize.width)
            self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: titleSize.width+margin, bottom: 0, right: -titleSize.width)
        case .vertical:
            /// 对比前后两者位置变化，初始时edgeInsets都是（0，0，0，0），最终状态，imageView在titleLabel上面，变化过程就好比将imageView向上移动了titleLabel的高度，所以top为-titleSize.heigth
            self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -imageSize.width, bottom: -imageSize.height-margin, right: 0)
            self.imageEdgeInsets = UIEdgeInsets.init(top: -titleSize.height-margin, left: 0, bottom: 0, right: -titleSize.width)
            break
        case .verticalReverse:
            /// 对比前后两者位置变化，初始时edgeInsets都是（0，0，0，0），最终状态，imageView在titleLabel下面，变化过程就好比将imageView向下移动了titleLabel的高度，所以bottom为-titleSize.heigth
            self.titleEdgeInsets = UIEdgeInsets.init(top: -imageSize.height-margin, left: -imageSize.width, bottom: 0, right: 0)
            self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: -titleSize.height-margin, right: -titleSize.width)
            break
        }
    }
}


extension UIButton {
    
    
    /// 对文字的设置 text + font + textColor + cornerRadius + selectTextColor + backgroundColor
    ///
    /// - Parameters:
    ///   - text: 文字
    ///   - font: 字体大小
    ///   - textColor: 文字颜色
    ///   - cornerRadius: 圆角大小 默认为0
    ///   - selectTextColor: 选中文字颜色，可选值
    ///   - backgroundColor: 背景颜色
    /// - Returns: UIButton
    public static func mc_make(
        text: String,
        font: UIFont,
        textColor: UIColor,
        selectTextColor: UIColor? = nil,
        cornerRadius: CGFloat = 0,
        backgroundColor: UIColor = UIColor.white,
        target: Any?,
        selector: Selector
        ) -> UIButton {
        
        let button = UIButton.init(type: .custom)
        button.setTitle(text, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        
        if selectTextColor != nil {
            button.setTitleColor(selectTextColor, for: .selected)
        }
        
        button.titleLabel?.font = font
        button.backgroundColor = backgroundColor
        if cornerRadius > 0 {
            button.layer.cornerRadius = cornerRadius
            button.layer.masksToBounds = true
        }
        
        button.addTarget(target, action: selector, for: UIControl.Event.touchUpInside)
        
        return button
    }
    
    
    /// 对图片的设置 image + selectImage + cornerRadius + backgroundColor
    ///
    /// - Parameters:
    ///   - image: 图片
    ///   - selectImage: 选中的图片
    ///   - cornerRadius: 圆角大小 默认为0
    ///   - backgroundColor: 背景颜色
    /// - Returns: UIButton
    public static func mc_make(
        image: UIImage,
        selectImage: UIImage? = nil,
        cornerRadius: CGFloat = 0,
        backgroundColor: UIColor = UIColor.white,
        target: Any?,
        selector: Selector
        ) -> UIButton {
        
        let button = UIButton.init(type: .custom)
        
        button.setImage(image, for: .normal)
        if selectImage != nil {
            button.setImage(selectImage, for: .selected)
        }
        button.backgroundColor = backgroundColor
        if cornerRadius > 0 {
            button.layer.cornerRadius = cornerRadius
            button.layer.masksToBounds = true
        }
        button.addTarget(target, action: selector, for: UIControl.Event.touchUpInside)
        
        return button
    }
    
    
    
    /// 对图片和文字的设置 text + font + textColor + image + cornerRadius + backgroundColor
    ///
    /// - Parameters:
    ///   - text: 文字
    ///   - font: 字体大小
    ///   - textColor: 字体颜色
    ///   - image: 图片
    ///   - cornerRadius: 圆角
    ///   - backgroundColor: 背景颜色
    /// - Returns: UIButton
    public static func mc_make(
        text: String,
        font: UIFont,
        textColor: UIColor,
        image: UIImage,
        cornerRadius: CGFloat = 0,
        backgroundColor: UIColor = UIColor.white,
        target: Any?,
        selector: Selector
        ) -> UIButton {
        
        let button = UIButton.init(type: .custom)
        button.setTitle(text, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.titleLabel?.font = font
        button.setImage(image, for: .normal)
        button.backgroundColor = backgroundColor
        
        
        if cornerRadius > 0 {
            button.layer.cornerRadius = cornerRadius
            button.layer.masksToBounds = true
        }
        
        button.addTarget(target, action: selector, for: UIControl.Event.touchUpInside)
        
        return button
    }
    
    
    /// 图片icon和文字位置
    ///
    /// - Parameters:
    ///   - text: 文字
    ///   - font: 字体大小
    ///   - textColor: 字体颜色
    ///   - image: 图片
    ///   - cornerRadius: 圆角
    ///   - backgroundColor: 背景颜色
    ///   - imageEdge: 图片偏移量
    ///   - titleEdge: 文字偏移量
    /// - Returns: UIButton
    public static func mc_makeIconBtn(
        text: String,
        font: UIFont,
        textColor: UIColor,
        image: UIImage,
        cornerRadius: CGFloat = 0,
        backgroundColor: UIColor = UIColor.white,
        imageEdge: UIEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0),
        titleEdge: UIEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0),
        target: Any?,
        selector: Selector
        ) -> UIButton {
        let button = UIButton.init(type: .custom)
        button.setTitle(text, for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.titleLabel?.font = font
        button.setImage(image, for: .normal)
        button.backgroundColor = backgroundColor
        button.imageEdgeInsets = imageEdge
        button.titleEdgeInsets = titleEdge
        if cornerRadius > 0 {
            button.layer.cornerRadius = cornerRadius
            button.layer.masksToBounds = true
        }
        
        button.addTarget(target, action: selector, for: UIControl.Event.touchUpInside)
        
        return button
    }
    
}

