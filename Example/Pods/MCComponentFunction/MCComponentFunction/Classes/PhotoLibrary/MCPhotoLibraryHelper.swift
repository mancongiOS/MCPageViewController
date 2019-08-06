//
//  MCPhotoLibraryHelper.swift
//  MCComponentFunction_Example
//
//  Created by 满聪 on 2019/7/4.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Foundation
public class MCPhotoLibraryHelper: NSObject {


    /// 打开自定义的相册
    ///
    /// - Parameters:
    ///   - target: 目标控制器，用来做页面跳转
    ///   - maxSelectCount: 最大选择图片数量
    ///   - completeHandler: 回调，图片数组
    public static func open(target: UIViewController, maxSelectCount: Int = Int.max, completeHandler:((_ images:[UIImage])->())?) {
        
        let vc = MCPhotoLibraryListViewController()
        vc.maxSelected = maxSelectCount
        vc.completeHandler = completeHandler
        
        let nav = UINavigationController.init(rootViewController: vc)
        target.present(nav, animated: true, completion: nil)
    }
}
