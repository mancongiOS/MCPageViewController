//
//  MCTool.swift
//  StoreManage
//
//  Created by MC on 2018/8/31.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit

public class MCTool: NSObject {
    
}


extension MCTool {
    /// 获取类名字符串
    public static func mc_getClassName(_ obj:Any) -> String {
        let mirro = Mirror(reflecting: obj)
        let className = String(describing: mirro.subjectType).components(separatedBy: ".").first!
        return className
    }
}


extension MCTool {
    
    
    /// 获取该app的缓存
    public static func mc_cacheSize() -> String {
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        var size = 0
        for file in fileArr! {
            let path = cachePath! + "/\(file)"
            // 取出文件属性
            let floder = try! FileManager.default.attributesOfItem(atPath: path)
            // 用元组取出文件大小属性
            for (abc, bcd) in floder {
                // 累加文件大小
                if abc == FileAttributeKey.size {
                    size += (bcd as AnyObject).integerValue
                }
            }
        }
        let mm = size / 1024 / 1024
        return String(mm) + "M"
    }
    
    /// 清理该app的缓存
    public static func mc_clearCache() {
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        // 遍历删除
        for file in fileArr! {
            let path = cachePath! + "/\(file)"
            if FileManager.default.fileExists(atPath: path) {
                do {
                    try FileManager.default.removeItem(atPath: path)
                } catch { }
            }
        }
    }
}



