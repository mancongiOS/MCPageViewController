//
//  MCRoute.swift
//  MCAPI
//
//  Created by MC on 2018/11/26.
//  Copyright © 2018 MC. All rights reserved.
//

import Foundation
import UIKit

fileprivate var Route_NameSpace = ""

public class MCRoute: NSObject {
    public var window : UIWindow? = nil
    public var tabBar : UITabBarController? = nil
    
    // 配置一级页面控制器,方便配置返回按钮（pop dismiss）
    public var subControllers: [String] = []
    
    //MARK: 单例
    static public let shared = MCRoute.init()
    private override init(){}
    
    public func perform(_ targetName: String,
                        params: [String: Any]?,
                        nameSpace:String = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String ?? "",
                        shouldCacheTarget: Bool) -> Any? {
        
        
        Route_NameSpace = nameSpace
        
        
        
        
        let targetClassString = nameSpace + "." + "Target_" + targetName
        let actionString = "Action_ViewController:"
        var target : NSObject? = cachedTarget[targetClassString] as? NSObject
        if target == nil {
            
            guard let targetClass = NSClassFromString(targetClassString) as? NSObject.Type else {
                // 这里是处理无响应请求的地方之一，这个demo做得比较简单，如果没有可以响应的target，就直接return了。实际开发过程中是可以事先给一个固定的target专门用于在这个时候顶上，然后处理这种请求的
                return nil
            }
            
            target = targetClass.init()
        }
        
        var newAction = NSSelectorFromString(actionString)
        
        if shouldCacheTarget == true {
            cachedTarget[targetClassString] = target
        }
        
        if target!.responds(to: newAction) {
            return target?.perform(newAction, with: params).retain().takeRetainedValue()
        }else {
            newAction = NSSelectorFromString("notFound:")
            if target!.responds(to: newAction) {
                // 这里是处理无响应请求的地方，如果无响应，则尝试调用对应target的notFound方法统一处理
                return target?.perform(newAction, with: params).retain().takeRetainedValue()
            }else {
                // 这里也是处理无响应请求的地方，在notFound都没有的时候，这个demo是直接return了。实际开发过程中，可以用前面提到的固定的target顶上的。
                cachedTarget.removeValue(forKey: targetClassString)
                return nil
            }
        }
    }
    
    func releaseCacheTarget(_ targetName: String) {
        let targetClassString = Route_NameSpace + "." + "Target_" + targetName
        cachedTarget.removeValue(forKey: targetClassString)
    }
    
    private lazy var cachedTarget: [String:Any] = {
        return [String:Any]()
    }()
    
    
    fileprivate var tempErrorView: UIView? = nil
    
    public var errorView: UIView? {
        get {
            return tempErrorView
        }
    }
    
    fileprivate var defultRootController : UIViewController? = nil
}

extension MCRoute {
    
    //MARK: 初始化window
    @discardableResult
    public func configWindow(_ rootController: UIViewController? = nil) -> UIWindow {
        window = UIWindow(frame: UIScreen.main.bounds)
        if rootController == nil {
            window!.rootViewController = defultRootController
        }else{
            window!.rootViewController = rootController
        }
        window?.backgroundColor = UIColor.white
        window!.makeKeyAndVisible()
        return window!
    }
    
    public func configRootController(_ controller: UIViewController) {
        defultRootController = controller
    }
    
    //根控制器
    public func rootController(_ controller: String? = nil) {
        UIApplication.shared.keyWindow?.rootViewController = defultRootController
    }
    
    //配置错误控制器
    public func configErrorController(_ errorView: UIView) {
        tempErrorView = errorView
    }
    
    //获取错误控制器
    public func errorController() -> MCErrorViewController {
        let evc = MCErrorViewController()
        evc.errorView = errorView
        return evc
    }
    
    
}


public protocol RouteTargetProtocol {
    func Action_ViewController(_ params: [String:Any]) -> UIViewController?
}



public protocol RouteProtocol where Self : UIViewController {
    init(_ dict:[String:Any])
}

extension RouteProtocol {
    public init(_ dict:[String:Any]) {
        self.init()
    }
}


