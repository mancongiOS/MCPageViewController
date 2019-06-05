//
//  UIViewController+Route.swift
//  QJS
//
//  Created by qiuchengxiang@gmail.com on 2017/12/14.
//  Copyright © 2017年 Zillion Fortune. All rights reserved.
//

import Foundation
import UIKit



fileprivate func getClassName(_ obj:Any) -> String {
    let mirro = Mirror(reflecting: obj)
    let className = String(describing: mirro.subjectType).components(separatedBy: ".").first!
    return className
}


// 前进
extension UIViewController {
    
    
    /// 页面跳转方法 （push or present）
    ///
    /// - Parameters:
    ///   - targetViewController: 目标控制器
    ///   - isHiddenBottomBarWhenBack: 返回的时候是否隐藏tabbar
    ///   - animated: 跳转页面动画是否打开
    public func mc_jump(to targetViewController: UIViewController, isHiddenBottomBarWhenBack: Bool = true, animated:Bool = true) {
        
        if self.navigationController == nil {
            self.present(targetViewController, animated: true, completion: nil)
        } else {
            
            let vc = getClassName(self)
            
            //如果目标控制器是一级页面，pop或dismiss后重新创建rootController
            
            if MCRoute.shared.subControllers.contains(vc) {
                self.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(targetViewController, animated: animated)
                self.hidesBottomBarWhenPushed = false
            } else {
                self.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(targetViewController, animated: animated)
                self.hidesBottomBarWhenPushed = isHiddenBottomBarWhenBack
            }
        }
    }
}


// 返回
extension UIViewController {
    
    
    /// 返回到tabbar
    ///
    /// - Parameter index: tabbar的下标 默认为0
    public func mc_backToTabbar(index: Int = 0) {
        MCRoute.shared.tabBar?.selectedIndex = index
        
        if navigationController != nil {
            if (navigationController?.viewControllers.count)! > 1 {
                navigationController?.popToRootViewController(animated: true)
                return
            }
        }
    }
    
    
    
    /// 页面返回方法
    ///
    /// - Parameter viewController: 可选值，如果填，就指定返回到该页面
    public func mc_backHandle(_ viewController: UIViewController? = nil) {
        
        var targetViewController : String?
        
        if viewController != nil {
            targetViewController = getClassName(viewController!)
        }
        
        //如果没有目标控制器，直接走返回方法
        guard targetViewController != nil else {
            
            if navigationController == nil {
                dismiss(animated: true, completion: nil)
            } else {
                if (navigationController?.viewControllers.count)! > 1 {
                    navigationController?.popViewController(animated: true)
                    return
                }
                
                if ((navigationController?.presentingViewController) != nil) {
                    navigationController?.dismiss(animated: true, completion: nil)
                } else {
                    navigationController?.popViewController(animated: true)
                }
            }
            
            return
        }
        
        //如果目标控制器存在于当前navigationController的stack中，直接pop
        for vc: UIViewController in (navigationController?.viewControllers)! {
            if getClassName(vc) == targetViewController {
                navigationController?.popToViewController(vc, animated: true)
                return
            }
        }
        
        
        
        //如果目标控制器是一级页面，pop或dismiss后重新创建rootController
        
        if MCRoute.shared.subControllers.contains(targetViewController ?? "") {
            if ((navigationController?.presentingViewController) != nil) {
                navigationController?.dismiss(animated: true, completion: nil)
                MCRoute.shared.rootController()
            }else {
                navigationController?.popToRootViewController(animated: true)
                MCRoute.shared.rootController()
            }
            return
        }
        
        
        //如果目标控制器不是一级页面，也不在当前navigationController的stack中，
        iterativeNavigation(targetViewController!, navigationController!) { (vc, presentingNav, presentedNav) in
            if presentingNav.viewControllers.last != vc {
                presentedNav.dismiss(animated: false, completion: {
                    presentingNav.popToViewController(vc, animated: true)
                })
            }else {
                presentedNav.dismiss(animated: true)
            }
        }
    }
    
    private typealias PresentingNav = UINavigationController
    private typealias PresentedNav = UINavigationController
    
    private func iterativeNavigation(_ targetViewController: String, _ nav: UINavigationController, handle:@escaping (UIViewController, PresentingNav, PresentedNav) -> ()) {
        if let presentingNavigation = nav.presentingViewController as? UINavigationController {
            for vc: UIViewController in presentingNavigation.viewControllers {
                if getClassName(vc) == targetViewController {
                    handle(vc, presentingNavigation, nav)
                    return
                }
            }
            if nav.presentingViewController != nil {
                nav.dismiss(animated: false, completion: {
                    self.iterativeNavigation(targetViewController,presentingNavigation, handle: handle)
                })
            }
        }else {
            print("route something wrong!")
        }
    }
    
    
}




