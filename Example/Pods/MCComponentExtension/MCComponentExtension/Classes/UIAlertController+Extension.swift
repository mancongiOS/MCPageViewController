//
//  UIAlertController+Extension.swift
//  MCAPI
//
//  Created by MC on 2018/11/26.
//

import Foundation
import UIKit

extension UIAlertController {
    
    /**
     *  alert  在指定控制器上显示提示框（一个AlertAction）
     */
    public static func mc_show( title: String,
                                message: String? = nil,
                                on viewController: UIViewController,
                                actionTitle: String = "确定",
                                confirm: ((UIAlertAction)->Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction.init(title: actionTitle, style: .cancel, handler: confirm)
        alert.addAction(action)
        viewController.present(alert, animated: true)
    }
    
    /**
     *  alert  在根视图控制器上显示提示框（一个AlertAction）
     */
    public static func mc_show(title: String,
                               message: String? = nil,
                               actionTitle: String = "确定",
                               confirm: ((UIAlertAction)->Void)?) {
        if var vc = UIApplication.shared.keyWindow?.rootViewController {
            
            if vc.isKind(of: UINavigationController.classForCoder()) {
                vc = (vc as! UINavigationController).visibleViewController!
            } else if vc.isKind(of: UITabBarController.classForCoder()) {
                vc = (vc as! UITabBarController).selectedViewController!
            }
            mc_show(title: title, message: message, on: vc, actionTitle: actionTitle, confirm: confirm)
        }
    }
    
    
    /**
     *  alert  在指定控制器上显示确认框（两个AlertAction）
     */
    public static func mc_confirm(title: String,
                                  message: String? = nil,
                                  on vc: UIViewController,
                                  actionTitle: String = "确定",
                                  actionCancelTitle: String = "取消",
                                  confirm: ((UIAlertAction)->Void)?,
                                  cancel: ((UIAlertAction)->Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionCancelTitle, style: .cancel, handler: cancel))
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: confirm))
        vc.present(alert, animated: true)
    }
    
    /**
     *  alert  在根视图控制器上显示确认框（两个AlertAction）
     */
    public static func mc_confirm(title: String,
                                  message: String? = nil,
                                  actionTitle: String = "确定",
                                  actionCancelTitle: String = "取消",
                                  confirm: ((UIAlertAction)->Void)?,
                                  cancel: ((UIAlertAction)->Void)? = nil) {
        
        if var vc = UIApplication.shared.keyWindow?.rootViewController {
            
            if vc.isKind(of: UINavigationController.classForCoder()) {
                vc = (vc as! UINavigationController).visibleViewController!
            } else if vc.isKind(of: UITabBarController.classForCoder()) {
                vc = (vc as! UITabBarController).selectedViewController!
            }
            
            mc_confirm(title: title, message: message, on: vc, actionTitle: actionTitle, actionCancelTitle: actionCancelTitle, confirm: confirm, cancel: cancel)
        }
    }
    
    
    /**
     *  actionSheet  在指定控制器上显示actionSheet（AlertAction根据数组数量决定）
     */
    public static func mc_actionSheet(title: String,
                                      message: String? = nil,
                                      on vc : UIViewController,
                                      items:[String],confirm : ((Int,String) -> Void)?,
                                      actionCancelTitle: String = "取消",
                                      cancel: ((UIAlertAction)->Void)? = nil) {
        
        let alter = UIAlertController.init(title: title, message: message, preferredStyle: .actionSheet)
        
        let cancle = UIAlertAction.init(title: actionCancelTitle, style: .cancel, handler: cancel)
        
        var index = 0
        for item in items {
            let i = index
            let confirm = UIAlertAction.init(title: item, style: UIAlertAction.Style.default) { (b) in
                confirm?(i,item)
            }
            alter.addAction(confirm)
            index += 1
        }
        alter.addAction(cancle)
        vc.present(alter, animated: true, completion: nil)
    }
    
    
    
    
    /**
     * actionSheet  在指定控制器上显示拍照或者相册
     * vc : 控制器
     * hander: 闭包，选取的item
     *
     */
    public static func mc_chooseImage(on vc: UIViewController,hander: ((String) -> Void)?) {
        
        let alter = UIAlertController.init(title: "选择图片", message: nil, preferredStyle: .actionSheet)
        
        let cancle = UIAlertAction.init(title: "取消", style: .cancel) { (b) in
            hander?("取消")
        }
        
        let photos = UIAlertAction.init(title: "拍照", style: .default) { (b) in
            hander?("拍照")
        }
        
        let libraries = UIAlertAction.init(title: "相册", style: .default) { (b) in
            hander?("相册")
        }
        
        alter.addAction(cancle)
        alter.addAction(photos)
        alter.addAction(libraries)
        
        vc.present(alter, animated: true, completion: nil)
    }
}


