//
//  Bundle+Extension.swift
//  MCAPI
//
//  Created by MC on 2018/11/26.
//

import Foundation
import UIKit


@objc extension Bundle {
    
    /**
     * 加载指定bundle下的图片资源
     * 在哪个pod下的哪个bundle下的image
     */
    public static func mc_loadImage(_ imageName: String, from bundleName: String, in podName: String) -> UIImage? {
        
        
        var associateBundleURL = Bundle.main.url(forResource: "Frameworks", withExtension: nil)
        associateBundleURL = associateBundleURL?.appendingPathComponent(podName)
        associateBundleURL = associateBundleURL?.appendingPathExtension("framework")
        
        
        if associateBundleURL == nil {
            print("获取bundle失败")
            return nil
        }
        
        
        let associateBunle = Bundle.init(url: associateBundleURL!)
        associateBundleURL = associateBunle?.url(forResource: bundleName, withExtension: "bundle")
        
        if associateBundleURL != nil {
            let bundle = Bundle.init(url: associateBundleURL!)
            let scale = Int(UIScreen.main.scale)
            
            // 适配2x还是3x图片
            let name = imageName + "@" + String(scale) + "x"
            let path = bundle?.path(forResource: name, ofType: "png")
            
            if path == nil {
                print("获取bundle失败")
                return nil
            }
            let image1 = UIImage.init(contentsOfFile: path!)
            return image1

        } else {
            return nil
        }
        

        
    }
}


