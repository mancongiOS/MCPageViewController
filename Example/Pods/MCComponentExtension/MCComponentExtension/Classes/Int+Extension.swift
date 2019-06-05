//
//  Int+Extension.swift
//  MCComponentExtension
//
//  Created by MC on 2018/12/14.
//

import UIKit


extension Int {
    
    /// Int类型的分，转为元为单位的
    ///
    /// - Parameters:
    ///   - isNeedUnit: 是否需要¥单位
    /// - Returns: String
    public func toYuanRMB(_ isNeedUnit:Bool = true) -> String {
        
        // 分为单位
        let figure = self
        
        
        let price = CGFloat(figure)
        let price1 = String(format: "%.2f", CGFloat(figure)/100)
        var price2 = String(format: "%.2f", CGFloat(figure)/100)
        let indexOne = price1.index(price1.endIndex, offsetBy: -1)
        let lastOne = price1.suffix(from: indexOne)
        let indexTwo = price1.index(price1.endIndex, offsetBy: -2)
        let lastTwo = price1.suffix(from: indexTwo)
        if lastOne == "0" {
            price2 = String.init(format: "%.1f", price/100)
        }
        if lastTwo == "00" {
            price2 = String.init(format: "%.0f", price/100)
        }
        
        return isNeedUnit ? ("¥" + price2) : price2
    }
}

//MARK: 类型转换
extension Int {
    
    /**
     * Int -> 字符串
     */
    public var stringValue: String {
        get {
            return String(self)
        }
    }
    
    
    /**
     * Int -> Float
     */
    public var folatValue: Float {
        get {
            return Float(self)
        }
    }
    
    /**
     * Int -> Double
     */
    public var doubleValue: Double {
        get {
            return Double(self)
        }
    }
    
    
    /**
     * Int -> NSNumber
     */
    public var numberValue: NSNumber {
        get {
            return NSNumber.init(value: self)
        }
    }
    
}
