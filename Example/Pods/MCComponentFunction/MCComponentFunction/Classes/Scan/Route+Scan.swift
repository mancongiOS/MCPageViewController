//
//  Route+Scan.swift
//  Alamofire
//
//  Created by MC on 2018/12/26.
//

import Foundation


fileprivate let nameSpace = "MCComponentFunction"

fileprivate let target_Scan = "Scan"


extension MCRoute {
    
    /**
     * 扫一扫页面
     */
    public func MCScanViewController(_ params: [String:Any]) -> UIViewController {
        let vc = perform(target_Scan, params: params, nameSpace: nameSpace, shouldCacheTarget: false)
        guard vc != nil else {
            return errorController()
        }
        
        if let vc2 = vc as? MCScanViewController {
            return vc2
        }else {
            return errorController()
        }
    }
}


/**
 * 扫一扫页面
 */
class Target_Scan: NSObject,RouteTargetProtocol {
    @objc func Action_ViewController(_ params: [String : Any]) -> UIViewController? {
        let vc = MCScanViewController(params)
        return vc
    }
}

