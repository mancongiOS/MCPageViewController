//
//  MCAppStore.swift
//  Alamofire
//
//  Created by MC on 2018/12/25.
//

import Foundation

public class MCAppStore: NSObject {
    
    public static let shared = MCAppStore.init()
    
    /**
     * 去App Store评分
     * @param AppID: app的Id
     */
    public func mc_toScore(_ AppID: String) {
        let urlStr = "itms-apps://itunes.apple.com/app/id\(AppID)?action=write-review"
        UIApplication.shared.openURL(URL.init(string: urlStr)!)
    }
    
    /**
     * 去App Store下载
     */
    
    public func mc_toUpdate(_ AppID: String) {
        
        let urlStr = "itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=\(AppID)"
        UIApplication.shared.openURL(URL.init(string: urlStr)!)
    }
}

