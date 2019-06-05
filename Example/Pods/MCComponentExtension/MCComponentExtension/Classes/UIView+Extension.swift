//
//  UIView+Extension.swift
//  MCComponentExtension
//
//  Created by MC on 2019/1/11.
//

import Foundation

extension UIView {
    /**
     * 将一个UIView视图转为图片
     */
    public func mc_makeImage() -> UIImage {
        let size = self.bounds.size
        
        /**
         * 第一个参数表示区域大小。
         第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。
         第三个参数就是屏幕密度了
         */
        UIGraphicsBeginImageContextWithOptions(size, true, UIScreen.main.scale)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}


extension UIView {
    /**
     * 通过贝塞尔曲线，裁切四个边的任意几个的圆角
     */
    public func mc_clipCorners(_ corner:UIRectCorner, cornerRadii:CGSize) {
        
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corner, cornerRadii: cornerRadii)
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
}
