//
//  MCClipImageTool.swift
//  MCAPI
//
//  Created by MC on 2018/9/18.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit

extension UIImage {
    
    /**
     * 翻转图片
     */
    func rotationImage(orientation:UIImage.Orientation) -> UIImage {
        
        var rotate : Double = 0.0;
        var rect = CGRect.init()
        var translateX : CGFloat = 0.0;
        var translateY : CGFloat = 0.0;
        var scaleX : CGFloat = 1.0;
        var scaleY : CGFloat = 1.0;
        
        let imageWidth = self.size.width
        let imageHeight = self.size.height

        
        // 根据方向旋转
        switch (orientation) {
        case .left:
            rotate = Double.pi / 2;
            rect = CGRect.init(x: 0, y: 0, width: imageHeight, height: imageWidth)
            translateX = 0
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case .right:
            rotate = 33 * Double.pi / 2;
            rect = CGRect.init(x: 0, y: 0, width: imageHeight, height: imageWidth)
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case .down:
            rotate = Double.pi
            rect = CGRect.init(x: 0, y: 0, width: imageWidth, height: imageHeight)
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRect.init(x: 0, y: 0, width: imageWidth, height: imageHeight)
            translateX = 0;
            translateY = 0;
            break;
        }
        
        
        //做CTM变换,并绘制图片
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext();
        context?.translateBy(x: 0, y: rect.size.height)
        context?.scaleBy(x: 1, y: -1)
        context?.rotate(by: CGFloat(rotate))
        context?.translateBy(x: translateX, y: translateY)
        context?.scaleBy(x: scaleX, y: scaleY)
        context?.draw(self.cgImage!, in: CGRect.init(x: 0, y: 0, width: rect.size.width, height: rect.size.height))
        let newPic = UIGraphicsGetImageFromCurrentImageContext();
        return newPic ?? UIImage.init()
    }
    
    
    /**
     * 判断图片和裁剪框的关系类型
     */
    func judgeRelationTypeWithCropSize(_ cropSize: CGSize) -> Int {
        
        var relationType = 0
        
        
        let crop_W = cropSize.width
        let crop_H = cropSize.height
        
        let image_W = self.size.width
        let image_H = self.size.height
        
        let imageRadio = image_W / image_H
        let cropRadio = crop_W / crop_H
        
        
        /** 裁切框宽高比 > 1
         0. 裁切框宽高比 >= 图片宽高比    imageView宽固定，高适配
         1. 裁切框宽高比 <  图片宽高比    imageView高固定，宽适配
         */
        
        /** 裁切框宽高比 = 1
         2. 裁切框宽高比 >= 图片宽高比    imageView宽固定，高适配
         3. 裁切框宽高比 <  图片宽高比    imageView高固定，宽适配
         */
        
        
        /** 裁切框宽高比 < 1
         4. 裁切框宽高比 >= 图片宽高比    imageView宽固定，高适配
         5. 裁切框宽高比 <  图片宽高比    imageView高固定，宽适配
         */
        
        if cropRadio > 1 {
            if cropRadio >= imageRadio {
                relationType = 0
            } else {
                relationType = 1
            }
        } else if cropRadio == 1 {
            if cropRadio >= imageRadio {
                relationType = 2
            } else {
                relationType = 3
            }
        } else {
            if cropRadio >= imageRadio {
                relationType = 4
            } else {
                relationType = 5
            }
        }
        
        return relationType
    }

    // 将图片裁剪为圆形
    public func clipCircularImage() -> UIImage {
        
        let imageWidth = self.size.width
        let imageHeight = self.size.height

        
        let arcCenterX = imageWidth / 2
        let arcCenterY = imageHeight / 2
        
        let radius = arcCenterX > arcCenterY ? arcCenterY : arcCenterX

        
        UIGraphicsBeginImageContext(self.size)
        let context = UIGraphicsGetCurrentContext()
        context!.beginPath()
        context?.addArc(center: CGPoint.init(x: arcCenterX, y: arcCenterY), radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: false)
        context?.clip()
        self.draw(in: CGRect.init(x: 0, y: 0, width: imageWidth, height: imageHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        
        return  newImage!
    }
}



@objc extension Bundle {
    
    /**
     * 获取bundle的路径。
     */
    @objc func getBundlePath(bundleName:String) -> String {
        let bundlePath = self.resourcePath!.appending("/\(bundleName).bundle")
        return bundlePath
    }
    
    
    /**
     * 加载指定bundle路径下的图片
     */
    @objc func loadImageFromBundleName(_ bundleName:String,imageName:String) -> UIImage {
        let resource_bundle = Bundle.init(path: self.getBundlePath(bundleName: bundleName))
        let image = UIImage.init(named: imageName, in: resource_bundle, compatibleWith: nil)
        return image ?? UIImage.init()
    }
}

