//
//  UIDevice+Extension.swift
//  Alamofire
//
//  Created by MC on 2018/11/26.
//

import Foundation

public enum iPhoneDevice {
    /// SE/5s/5c/5 机型
    case _SE_5s_5c_5
    /// 6/6s／7／8 机型
    case _8_7_6s_6
    /// 6+/6s+／7+／8+ 机型
    case _8plus_7plus_6sPlus_6plus
    /// X / XS 机型
    case _X_XS
    /// XR / XSMax 机型
    case _XSMax_XR
    /// 未知机型
    case _undefined
}


extension UIDevice {
    
    
    /// 屏幕的比例
    public static let scale: CGFloat               = UIScreen.main.scale
    
    /// UI尺寸针对width == 375，缩放
    public static let zoomUI: CGFloat              = UIScreen.main.bounds.size.width / 375
    
    ///屏幕宽
    public static let width: CGFloat               = UIScreen.main.bounds.size.width
    
    ///屏幕高
    public static let height: CGFloat              = UIScreen.main.bounds.size.height
    
    ///状态栏高度
    public static let statusBarHeight: CGFloat     = UIApplication.shared.statusBarFrame.height
    
    /// tabbar的高度
    public static let tabBarHeight: CGFloat        = 49 + bottomSafeAreaHeight
    
    ///导航栏高度
    public static let navigationBarHeight: CGFloat = 44 + statusBarHeight
    
    /// 顶部安全区域的高度 (20 or 44)
    public static let topSafeAreaHeight: CGFloat   = UIDevice.safeAreaInsets().top
    
    /// 底部安全区域 (0 or 34)
    public static let bottomSafeAreaHeight: CGFloat = UIDevice.safeAreaInsets().bottom
    
    
    private static func safeAreaInsets() -> (top: CGFloat, bottom: CGFloat) {
        if #available(iOS 11.0, *) {
            
            let inset = UIApplication.shared.delegate?.window??.safeAreaInsets
            
            let top = inset?.top ?? 0
            
            return (top == 0 ? 20 : top, inset?.bottom ?? 0)
        } else {
            return (20, 0)
        }
    }
}


extension UIDevice {
    
    /// 版本号
    public static let appVersion     = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String ?? ""
    /// 构建号
    public static let appbBuild      = Bundle.main.infoDictionary!["CFBundleVersion"] as? String ?? ""
    /// app的名称
    public static let appName        = Bundle.main.infoDictionary!["CFBundleDisplayName"] as? String ?? ""
    /// 工程名
    public static let appProjectName = Bundle.main.infoDictionary!["CFBundleName"] as? String ?? ""
    
    
    /**
     ------------------------------------------------------
     设备              逻辑分辨率(point)    设备分辨率(pixel)
     
     ------------------------------------------------------
     SE/5s/5c/5       320x568            640x1136
     6/6s／7／8        375x667            750x1334
     6+/6s+／7+／8+    414x736            1080x1920
     X(S)             375x812            1125x2436
     XR               414x896            828x1792
     XS Max           414x896            1242x2688
     */
    public static func mc_iPhoneModels() -> iPhoneDevice {
        
        var model : iPhoneDevice
        
        switch (UIDevice.width,UIDevice.height) {
        case (320,568):
            model = iPhoneDevice._SE_5s_5c_5
        case (375,667):
            model = iPhoneDevice._8_7_6s_6
        case (414,736):
            model = iPhoneDevice._8plus_7plus_6sPlus_6plus
        case (375,812): // X 和 XS
            model = iPhoneDevice._X_XS
        case (414,896): // XR 和 XS Max
            model = iPhoneDevice._XSMax_XR
        default:
            model = iPhoneDevice._undefined
        }
        
        return model
    }
    
    /// 是否是 iPhoneX
    var mc_isIPhoneX: Bool {
        var iPhoneX: Bool = false
        if UIDevice.current.userInterfaceIdiom != UIUserInterfaceIdiom.phone {
            return iPhoneX
        }
        if #available(iOS 11.0, *) {
            if Double((UIApplication.shared.delegate?.window??.safeAreaInsets.bottom)!) > 0.0 {
                iPhoneX = true
            }
        }
        return iPhoneX
    }
}





extension UIDevice {
    
    
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
