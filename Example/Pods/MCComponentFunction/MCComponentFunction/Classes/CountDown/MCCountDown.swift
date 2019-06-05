//
//  MCCountDown.swift
//  MCAPI
//
//  Created by MC on 2018/7/30.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit

/**
 * 时间格式应用 https://www.cnblogs.com/mancong/p/5422471.html
 */


public protocol MCCountDownDelegate : NSObjectProtocol {
    // 进行中
    func MCCountDownOngoing(time:MCCountDownStruct)
    // 结束
    func MCCountDownOver()
}


public class MCCountDown: NSObject {
    
    weak public var delegate : MCCountDownDelegate?
    
    private var second = 0
    private var minit = 0
    private var hour = 0
    private var day = 0
    private var nanosecond = 0
    
    private var timer : Timer?
    
    
    public func mc_openCountdown(start:String,end:String,format:String) -> MCCountDownStruct {
        
        // 防止重复调用定时器，如果定时器存在就销毁。
        if timer != nil {
            destructionCountDown()
        }
        
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.init(identifier: "GMT")
        
        let createDate = dateFormatter.date(from: start)
        let endDate = dateFormatter.date(from: end)
        
        
        let calendar = Calendar.current
        let unit:Set<Calendar.Component> = [.day,.hour,.minute,.second,.nanosecond]
        let commponent:DateComponents = calendar.dateComponents(unit, from: createDate!, to: endDate!)
        
        second      = commponent.second     ?? 0
        minit       = commponent.minute     ?? 0
        hour        = commponent.hour       ?? 0
        day         = commponent.day        ?? 0
        nanosecond  = commponent.nanosecond ?? 0
        
        let time = MCCountDownStruct(day:day,hour:hour,minit:minit,second:second,nanosecond:nanosecond)
        
        // 倒计时结束
        if  nanosecond == 0 && second == 0 && minit == 0 && hour == 0 && day == 0 {
            delegate?.MCCountDownOver()
            return time
        } else {
            timer = Timer.scheduledTimer(timeInterval: 1/10, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            RunLoop.main.add(timer!, forMode: RunLoop.Mode.common)
        }
        
        return time
    }
    
    
    // 停止倒计时
    public func mc_stopCountDown() {
        
        destructionCountDown()
        
        day = 0
        hour = 0
        minit = 0
        second = 0
        nanosecond = 0
        
        let time = MCCountDownStruct(day:day,hour:hour,minit:minit,second:second,nanosecond:nanosecond)
        delegate?.MCCountDownOngoing(time: time)
    }
    
    
    @objc private func timerAction() {
        
        nanosecond = nanosecond - 1
        
        if nanosecond == -1 {
            nanosecond = 9
            
            second = second - 1
            
            if second == -1 {
                second = 59
                minit = minit - 1
                if minit == -1 {
                    minit = 59
                    hour = hour - 1
                    if hour == -1 {
                        hour = 23
                        day = day - 1
                    }
                }
            }
        }
        
        if  nanosecond == 0 && second == 0 && minit == 0 && hour == 0 && day == 0 {
            
            delegate?.MCCountDownOver()
            self.timer?.invalidate()
            timer = nil
        }
        let time = MCCountDownStruct(day:day,hour:hour,minit:minit,second:second,nanosecond:nanosecond)
        delegate?.MCCountDownOngoing(time: time)
    }
    
    // 销毁定时器
    private func destructionCountDown() {
        timer?.invalidate()
        timer = nil
    }
    
    
    deinit {
        destructionCountDown()
    }
}


public struct MCCountDownStruct {
    var day        : Int
    var hour       : Int
    var minit      : Int
    var second     : Int
    var nanosecond : Int
}


