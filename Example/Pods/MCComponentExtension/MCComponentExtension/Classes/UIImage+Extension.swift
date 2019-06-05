//
//  UIImage+Extension.swift
//  MCAPI
//
//  Created by MC on 2018/11/26.
//

import Foundation
import UIKit


//MARK: 图片裁切，压缩等操作
extension UIImage {
    
    /// 压缩上传图片到指定字节
    ///
    /// - Parameter length: 压缩后最大字节大小
    /// - Returns: 压缩后的图片
    public func mc_compress(to length: Int) -> UIImage {
        
        let newSize = self.mc_zoomByMaxSide(300)
        let newImage = self.mc_resize(newSize: newSize)
        
        var compress:CGFloat = 0.9
        var data = newImage.jpegData(compressionQuality: compress)
        
        
        while (data?.count)! > length && compress > 0.01 {
            compress -= 0.02
            data = newImage.jpegData(compressionQuality: compress)
        }
        let image = UIImage.init(data: data!) ?? UIImage()
        return image
    }
    
    
    /// 重设图片的size
    ///
    /// - Parameter newSize: 指定的size
    /// - Returns: 重设的图片
    public func mc_resize(newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? UIImage()
    }
    
    /// 通过指定图片最长边，获得等比例的图片size 和mc_resize方法结合使用
    ///
    /// - Parameter maxSide: 图片允许的最长宽度（高度）
    /// - Returns: 获得等比例的size
    public func mc_zoomByMaxSide(_ maxSide: CGFloat) -> CGSize {
        
        var newWidth:CGFloat = 0.0
        var newHeight:CGFloat = 0.0
        let width = self.size.width
        let height = self.size.height
        
        if (width > maxSide || height > maxSide){
            
            if (width > height) {
                newWidth = maxSide;
                newHeight = newWidth * height / width;
            }else if(height > width){
                newHeight = maxSide;
                newWidth = newHeight * width / height;
            }else{
                newWidth = maxSide;
                newHeight = maxSide;
            }
        }
        return CGSize(width: newWidth, height: newHeight)
    }
    
    /**
     * 裁切指定区域（CGRect）获取图片
     */
    public func mc_cropByRect(_ rect:CGRect) -> UIImage {
        
        let imageRef = self.cgImage?.cropping(to: rect)
        let image = UIImage.init(cgImage: imageRef!, scale: self.scale, orientation: self.imageOrientation)
        return image
    }
    
}


//MARK: 创建图片
extension UIImage {
    
    
    /**
     * 更改图片颜色 统一渲染为一个纯色。注意图片上透明的使用。
     */
    public func mc_render(by color : UIColor) -> UIImage {
        let drawRect = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        
        color.setFill()
        UIRectFill(drawRect)
        draw(in: drawRect, blendMode: CGBlendMode.destinationIn, alpha: 1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }
    
    
    
    /**
     * 修复图片旋转
     */
    public func mc_repairOrientation() -> UIImage {
        if self.imageOrientation == .up {
            return self
        }
        var transform = CGAffineTransform.identity
        switch self.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: .pi)
            break
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.rotated(by: .pi / 2)
            break
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: self.size.height)
            transform = transform.rotated(by: -.pi / 2)
            break
        default:
            break
        }
        switch self.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
            break
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: self.size.height, y: 0);
            transform = transform.scaledBy(x: -1, y: 1)
            break
        default:
            break
        }
        let ctx = CGContext(data: nil, width: Int(self.size.width), height: Int(self.size.height), bitsPerComponent: self.cgImage!.bitsPerComponent, bytesPerRow: 0, space: self.cgImage!.colorSpace!, bitmapInfo: self.cgImage!.bitmapInfo.rawValue)
        ctx?.concatenate(transform)
        switch self.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx?.draw(self.cgImage!, in: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(size.height), height: CGFloat(size.width)))
            break
        default:
            ctx?.draw(self.cgImage!, in: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(size.width), height: CGFloat(size.height)))
            break
        }
        let cgimg: CGImage = (ctx?.makeImage())!
        let img = UIImage(cgImage: cgimg)
        return img
    }
}



extension UIImage {
    
    /// 1:1 占位图
    public static let mc_placeholder_1x1 = Placeholder_1x1()
    /// 2:1 占位图
    public static let mc_placeholder_2x1 = Placeholder_2x1()
    /// 3:1 占位图
    public static let mc_placeholder_3x1 = Placeholder_3x1()
    /// 3:2 占位图
    public static let mc_placeholder_3x2 = Placeholder_3x2()
    /// 5:3 占位图
    public static let mc_placeholder_5x3 = Placeholder_5x3()
    
    
    
    private static func Placeholder_1x1() -> UIImage {
        
        let image = Bundle.mc_loadImage("PlaceHolderImage", from: "MCComponentExtensionBundle", in: "MCComponentExtension")
        return mc_placeholder(size: (100,100), logoImage: image)
    }
    
    private static func Placeholder_2x1() -> UIImage {
        let image = Bundle.mc_loadImage("PlaceHolderImage", from: "MCComponentExtensionBundle", in: "MCComponentExtension")
        return mc_placeholder(size: (200,100), logoImage: image)
    }
    
    private static func Placeholder_3x1() -> UIImage {
        let image = Bundle.mc_loadImage("PlaceHolderImage", from: "MCComponentExtensionBundle", in: "MCComponentExtension")
        return mc_placeholder(size: (300,100), logoImage: image)
    }
    
    
    private static func Placeholder_3x2() -> UIImage {
        
        let image = Bundle.mc_loadImage("PlaceHolderImage", from: "MCComponentExtensionBundle", in: "MCComponentExtension")
        return mc_placeholder(size: (300,200), logoImage: image)
    }
    
    
    private static func Placeholder_5x3() -> UIImage {
        let image = Bundle.mc_loadImage("PlaceHolderImage", from: "MCComponentExtensionBundle", in: "MCComponentExtension")
        return mc_placeholder(size: (500,300), logoImage: image)
    }
    
    
    
    
    /// 生成一个替代图
    ///
    /// - Parameters:
    ///   - size: 生成图片的尺寸
    ///   - logoImage: logo图片
    ///   - bgColor: 生成的图片背景颜色
    /// - Returns: 图片
    public static func mc_placeholder (
        size     :(width:CGFloat,height:CGFloat) = (200,100),
        logoImage: UIImage? = UIImage.init(),
        bgColor  : UIColor = UIColor.init(red: 242/255.0, green: 242/255.0, blue: 242/255.0, alpha: 1)
        ) -> UIImage {
        
        
        let size = CGSize.init(width: size.0, height: size.1)
        
        
        let containerW = size.width
        let containerH = size.height
        
        var logoW = logoImage?.size.width ?? size.width / 2
        var logoH = logoImage?.size.height ?? size.height / 2
        
        var needScale : CGFloat = 1
        if logoW >= containerW || logoH >= containerH {
            
            let wScale = logoW / containerW
            let hScale = logoH / containerH
            
            if wScale > hScale {
                needScale = 1 / wScale
            } else {
                needScale = 1 / hScale
            }
        }
        
        logoW = logoW * needScale * 0.8
        logoH = logoH * needScale * 0.8
        
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        
        // 绘图
        bgColor.set()
        UIRectFill(CGRect.init(x: 0, y: 0, width: size.width, height: size.height))
        
        let imageX = containerW / 2 - logoW / 2
        let imageY = containerH / 2 - logoH / 2
        logoImage?.draw(in: CGRect.init(x: imageX, y: imageY, width: logoW, height: logoH))
        
        let resImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resImage ?? UIImage.init()
    }
}



