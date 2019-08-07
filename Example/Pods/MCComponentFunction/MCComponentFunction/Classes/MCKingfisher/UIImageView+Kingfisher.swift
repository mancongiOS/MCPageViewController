//
//  UIImageView+Kingfisher.swift
//  MCComponentExtension
//
//  Created by 满聪 on 2019/5/24.
//

import Foundation

import Kingfisher


extension UIImageView {
    
    /// 加载网络图片
    ///
    /// - Parameters:
    ///   - urlString: 图片url字符串
    ///   - placeholder: 占位图
    ///   - complete: 返回加载的Image的闭包
    public func mc_setImage(with urlString: String?, placeholder: UIImage?, complete: ((_ image: UIImage?) -> ())? = nil) {
        
        guard let urlString = urlString,
            let url = URL(string: urlString) else {
                self.image = placeholder
                return
        }
        
        self.kf.setImage(with: url, placeholder: placeholder) { (image, _, _, _) in
            
            if complete != nil {
                complete!(image)
            }
        }
    }
}
