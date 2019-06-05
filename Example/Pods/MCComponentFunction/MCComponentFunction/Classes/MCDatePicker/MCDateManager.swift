//
//  MCDateManager.swift
//  MCAPI
//
//  Created by MC on 2018/8/15.
//  Copyright © 2018年 MC. All rights reserved.
//

import Foundation


/**
 * 根据时间格式将字符串 -> 时间类
 * 默认时间格式:yyyy-MM-dd
 */
public func MCDateManager_getDateFromString(_ dateString:String,dateFormat:String = "yyyy-MM-dd") -> Date {
    let dateFormatter = DateFormatter.init()
//    dateFormatter.locale = Locale.init(identifier: "zh_CN")
    dateFormatter.dateFormat = dateFormat
    let date = dateFormatter.date(from: dateString)!
    return date
}


/**
 * 根据时间格式将时间类 -> 字符串
 * 默认时间格式:yyyy-MM-dd HH:mm:ss
 */
public func MCDateManager_getTimeStrFromDate (_ date:Date,dateFormat:String = "yyyy-MM-dd") -> String {
//    let localDate = MCDateManager_getLocalDateFromWorldDate(date)
    let dateFormatter = DateFormatter.init()
    dateFormatter.dateFormat = dateFormat
    let str = dateFormatter.string(from: date)
    return str
}



/**
 * 获取日期的年月日对象
 */
public func MCDateManager_getDateComponents(date:Date) -> DateComponents {
    let calendar = Calendar.current
    let unit:Set<Calendar.Component> = [.year,.month,.day]
    let components = calendar.dateComponents(unit, from: date)
    return components
}


/**
 * 世界时间转为本地时间
 */
public func MCDateManager_getLocalDateFromWorldDate(_ date:Date) -> Date {
    let localTimeZone = TimeZone.current
    let offset = localTimeZone.secondsFromGMT(for: date) 
    let localDate = date.addingTimeInterval(Double(offset))
    return localDate
}


/**
 * 比较两个时间大小
 * one < two的情况return -1 ||||
 * one = two的情况return 0  ||||
 * one > two的情况teturn 1  ||||
 */
public func MCDateManager_compareTwoDate(one:Date,two:Date) -> Int {
    if one.compare(two) == .orderedAscending {  // 升序
        return -1
    }
    
    if one.compare(two) == .orderedSame {  // 相等
        return 0
    }
    
    if one.compare(two) == .orderedDescending {  // 降序
        return 1
    }
    
    return 0
}
