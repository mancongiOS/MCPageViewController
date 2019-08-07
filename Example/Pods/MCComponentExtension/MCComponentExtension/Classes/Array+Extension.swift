//
//  Array+Extension.swift
//  GMJKExtension
//
//  Created by 满聪 on 2019/7/31.
//  参考至： EFSafeArray created of EyreFree

import Foundation

// ~
postfix operator ~

public postfix func ~ (value: Int?) -> JKSafeArray? {
    return JKSafeArray(value: value)
}

public postfix func ~ (value: Range<Int>?) -> JKSafeRange? {
    return JKSafeRange(value: value)
}

public postfix func ~ (value: CountableClosedRange<Int>?) -> JKSafeRange? {
    guard let value = value else {
        return nil
    }
    return JKSafeRange(value: Range<Int>(value))
}

// Struct
public struct JKSafeArray {
    var index: Int
    init?(value: Int?) {
        guard let value = value else {
            return nil
        }
        self.index = value
    }
}

public struct JKSafeRange {
    var range: Range<Int>
    init?(value: Range<Int>?) {
        guard let value = value else {
            return nil
        }
        self.range = value
    }
}

// subscript
public extension Array {
    
    
    /// 单个
    subscript(index: JKSafeArray?) -> Element? {
        get {
            if let index = index?.index {
                return (self.startIndex..<self.endIndex).contains(index) ? self[index] : nil
            }
            return nil
        }
        set {
            if let index = index?.index, let newValue = newValue {
                if (self.startIndex ..< self.endIndex).contains(index) {
                    self[index] = newValue
                }
            }
        }
    }
    
    /// 范围
    subscript(bounds: JKSafeRange?) -> ArraySlice<Element>? {
        get {
            if let range = bounds?.range {
                return self[range.clamped(to: self.startIndex ..< self.endIndex)]
            }
            return nil
        }
        set {
            if let range = bounds?.range, let newValue = newValue {
                self[range.clamped(to: self.startIndex ..< self.endIndex)] = newValue
            }
        }
    }
}
