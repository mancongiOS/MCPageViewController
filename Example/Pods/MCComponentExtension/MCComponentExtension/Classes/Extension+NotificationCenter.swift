//
//  Extension+NotificationCenter.swift
//  CityPlatform
//
//  Created by GY on 2018/12/21.
//  Copyright © 2018年 MC. All rights reserved.
//

import Foundation
import UIKit


/// 可继续扩展
extension Notification.Name {
    
    /// 通知名的前缀, 请拼接上去，防止重复
    public static let notName = "MC.Notification.Name."
    
    /// 接收到远程推送
    public static let remotePush = Notification.Name(notName + "remotePush")
    
    /// 重新登录
    public static let reLogin  = NSNotification.Name(notName +  "reLogin")
    
    /// 登陆/退出
    public static let login  = NSNotification.Name(notName + "login")
}






extension NotificationCenter {
    
    public static let shared = NotificationCenter.default
    
    
    /// 发送通知
    public func mc_post(_ name: Notification.Name, object: Any? = nil) {
        
        NotificationCenter.default.post(name: name, object: object, userInfo: nil)
    }
    
    /// 监听通知
    public func mc_addObserver(_ name: Notification.Name, vc: Any, selector: Selector, object: Any? = nil) {
        NotificationCenter.default.addObserver(vc, selector: selector, name: name, object: object)
    }
    
    /// 移除通知
    public func mc_remove(_ name: Notification.Name,vc: Any, object: Any? = nil) {
        NotificationCenter.default.removeObserver(vc, name: name, object: object)
    }
}
