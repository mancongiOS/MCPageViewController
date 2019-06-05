//
//  UserDefaults+Extension.swift
//  MCAPI
//
//  Created by MC on 2018/11/26.
//

import Foundation

import UIKit
public extension UserDefaults {
    
    
    /**
     * 版本信息
     */
    struct Version : UserDefaultsSettable {
        public enum defaultKeys: String {
            case version
            case build
        }
    }
    
    /**
     * 地理位置信息
     */
    struct LocationInfo: UserDefaultsSettable {
        public enum defaultKeys: String {
            case latitude
            case longitude
            case country
            case province
            case city
            case area
            /// 详细地址
            case detail
            /// 全路径地址
            case address
        }
    }
    
    
    
    
}




public protocol UserDefaultsSettable {
    associatedtype defaultKeys: RawRepresentable
}

extension UserDefaultsSettable where defaultKeys.RawValue==String {
    static public func set(value: Any, forKey key: defaultKeys) {
        let aKey = key.rawValue
        UserDefaults.standard.set(value, forKey: aKey)
    }
    
    
    static public func getString(forKey key: defaultKeys) -> String? {
        let aKey = key.rawValue
        let value = UserDefaults.standard.string(forKey: aKey)
        return value
    }
    
    static public func getArray(forKey key: defaultKeys) -> [Any]? {
        let aKey = key.rawValue
        
        let value = UserDefaults.standard.array(forKey: aKey)
        
        return value
    }
    
    static public func getDictionary(forKey key: defaultKeys) -> [String:Any]? {
        let aKey = key.rawValue
        
        let value = UserDefaults.standard.dictionary(forKey: aKey)
        return value
    }
}

