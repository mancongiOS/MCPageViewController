//
//  Time+Extension.swift
//  MCComponentExtension
//
//  Created by 满聪 on 2019/7/20.
//

import Foundation

//  指定格式化方式，只创建一次，效率高
private let dateFormatter = DateFormatter()

extension String {
    
    /// 字符串转字符串
    public func mc_toTimeStr(_ dateFormatStr: String = "yyyy-MM-dd HH:mm:ss") -> String {
        dateFormatter.dateFormat = dateFormatStr
        let date = dateFormatter.date(from: self)
        return dateFormatter.string(from: date ?? Date())
    }

    /// 字符串转Date
    public func mc_toDate(_ dateFormatStr: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        
        dateFormatter.dateFormat = dateFormatStr
        let date = dateFormatter.date(from: self)
        return date
    }
    
    
    /// 时间字符串转时间戳
    public func mc_toTimeStamp(_ dateFormatStr: String = "yyyy-MM-dd HH:mm:ss") -> TimeInterval {
        
        dateFormatter.dateFormat = dateFormatStr
        dateFormatter.locale = Locale.current
        let date = dateFormatter.date(from: self)
        let dateStamp:TimeInterval = date!.timeIntervalSince1970
        return dateStamp
    }
    
    
    /// 时间字符串转智能显示时间
    public func mc_toWisdomTime(_ dateFormatStr: String = "yyyy-MM-dd HH:mm:ss") -> String {
        dateFormatter.dateFormat = dateFormatStr
        let date = dateFormatter.date(from: self) ?? Date()
        return date.mc_toWisdomTime()
    }
}


extension TimeInterval {
    
    /// 时间戳转时间字符串
    public func mc_toTimeStr(_ dateFormatStr: String = "yyyy-MM-dd HH:mm:ss") -> String {
        
        let date = Date.init(timeIntervalSince1970: self)
        dateFormatter.dateFormat = dateFormatStr
        return dateFormatter.string(from: date)
    }
    
    /// 时间戳转Date
    public func mc_toDate() -> Date {
        return Date.init(timeIntervalSince1970: self)
    }
    
    /// 时间戳转智能时间
    public func mc_toWisdomTime() -> String {
        let date = Date.init(timeIntervalSince1970: self)
        return date.mc_toWisdomTime()
    }
    
}





extension Date {
    
    ///Date转字符串
    public func mc_toTimeStr(_ dateFormatStr: String = "yyyy-MM-dd HH:mm:ss") -> String {
        
        dateFormatter.dateFormat = dateFormatStr
        let str = dateFormatter.string(from: self)
        return str
    }
    
    ///Date转时间戳
    public func mc_toTimeStamp() -> TimeInterval {
        let dateStamp:TimeInterval = self.timeIntervalSince1970
        return dateStamp
    }
    
    
    
    /// 支付串转智能显示时间
    public func mc_toWisdomTime() -> String {
        //是今年
        if isThisYear(createAtDate: self) {
            //  日历对象
            let currentCalendar = Calendar.current
            if currentCalendar.isDateInToday(self) {
                
                let timeinterVal: TimeInterval = abs(self.timeIntervalSinceNow)
                if timeinterVal < 60 {
                    return "刚刚"
                } else if timeinterVal < 3600 {
                    let result = timeinterVal / 60
                    return "\(Int(result))分钟前"
                } else {
                    let result = timeinterVal / 3600
                    return "\(Int(result))小时前"
                }
            } else if currentCalendar.isDateInYesterday(self) { //  表示昨天
                dateFormatter.dateFormat = "昨天 HH:mm"
            } else { //  其它
                dateFormatter.dateFormat = "MM-dd HH:mm"
            }
        } else { //  不是今年
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        }
        
        return dateFormatter.string(from: self)
    }
}







///  根据指定时间对象判断是否是今年
private func isThisYear(createAtDate: Date) -> Bool {
    
    //  指定格式化方式
    dateFormatter.dateFormat = "yyyy"
    //  获取时间的年份
    let createAtYear = dateFormatter.string(from: createAtDate)
    //  获取当前时间的年份
    let currentDateYear = dateFormatter.string(from: Date())
    //  判断时间年份是否相同
    return createAtYear == currentDateYear
}
