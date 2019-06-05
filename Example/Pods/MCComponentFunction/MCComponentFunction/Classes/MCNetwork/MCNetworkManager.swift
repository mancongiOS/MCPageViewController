//
//  MCNetworkManager.swift
//  MCAPI
//
//  Created by MC on 2018/10/23.
//  Copyright © 2018年 MC. All rights reserved.
//

import Foundation
import Alamofire


public class MCNetworkManager {
    // 网络监听
    //shared instance
    public static let shared = MCNetworkManager()
    
    private let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.apple.com")
    
    public typealias RespnseClosure<T> = (MCNetworkStatus) -> Void
    public func startNetworkReachabilityObserver(response:@escaping RespnseClosure<MCNetworkStatus>) {
        
        reachabilityManager?.listener = { status in
            switch status {
                
            case .notReachable:
                response(.notReachable)
            case .unknown :
                response(.unknown)
                
            case .reachable(.ethernetOrWiFi):
                response(.WIFI)
                
            case .reachable(.wwan):
                response(.WWAN)
            }
        }
        
        // start listening
        reachabilityManager?.startListening()
    }
    // 销毁
    deinit {
        reachabilityManager?.stopListening()
    }
}

public enum MCNetworkStatus {
    case notReachable
    case unknown
    case WIFI
    case WWAN
}

