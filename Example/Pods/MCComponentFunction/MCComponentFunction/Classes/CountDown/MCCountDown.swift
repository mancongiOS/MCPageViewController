//
//  MCCountdown.swift
//  MCAPI
//
//  Created by MC on 2018/7/30.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit

/**
 * 时间格式应用 https://www.cnblogs.com/mancong/p/5422471.html
 */


public protocol MCCountdownDelegate : NSObjectProtocol {
    /// 进行中
    func countdown(_ countdown: MCCountdown, ongoingTime time: MCCountdownStruct)
    
    /// 结束
    func countdownEnd(_ countdown: MCCountdown)

    /// 开始倒计时
    func countdownStart(_ countdown: MCCountdown)
}


/// 让协议可选实现
extension MCCountdownDelegate {
    
    public func countdown(_ countdown: MCCountdown, ongoingTime time: MCCountdownStruct) { }
    
    public func countdownEnd(_ countdown: MCCountdown) { }
    
    public func countdownStart(_ countdown: MCCountdown) { }
}

/// 倒计时的时间间隔 是秒还是分秒（1/10秒）
public enum MCCountdownInterval: TimeInterval {
    case nanosecond = 0.1
    case seconds = 1
}

public class MCCountdown: NSObject {
    
    weak public var delegate : MCCountdownDelegate?
    
    // 倒计时的时间间隔
    private var interval: MCCountdownInterval = .seconds
    private var second = 0
    private var minit = 0
    private var hour = 0
    private var day = 0
    private var nanosecond = 0
    
    private var timer : Timer?
    
    
    
    /// 开启倒计时
    ///
    /// - Parameters:
    ///   - start: 开始的时间点
    ///   - end: 结束的时间点
    ///   - format: 时间格式
    ///   - interval: 倒计时间隔时间单位
    public func mc_open(start: String,
                                 end: String,
                                 format: String = "yyyy-MM-dd HH:mm:ss", interval: MCCountdownInterval = .seconds) {
        
        self.interval = interval
        
        // 防止重复调用定时器，如果定时器存在就销毁。
        if timer != nil {
            destructionTimer()
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
        
        openTimer()
        /// 倒计时开启
        delegate?.countdownStart(self)
    }
    
    
    
    /// 开启倒计时
    ///
    /// - Parameters:
    ///   - allSecondsTime: 倒计时的总时长
    ///   - interval: 倒计时的时间间隔单位
    public func mc_open(allSecondsTime: Int, interval: MCCountdownInterval = .seconds) {
        
        self.interval = interval
        
        // 防止重复调用定时器，如果定时器存在就销毁。
        if timer != nil {
            destructionTimer()
        }

        second      = allSecondsTime
        minit       = 0
        hour        = 0
        day         = 0
        nanosecond  = 0
        
        openTimer()
        /// 倒计时开启
        delegate?.countdownStart(self)
    }
    
    
    
    
    
    
    /// 主动停止倒计时
    public func mc_stopCountdown() {
        
        destructionTimer()
        
        day = 0
        hour = 0
        minit = 0
        second = 0
        nanosecond = 0
        
        delegate?.countdownEnd(self)
    }
    
    
    @objc private func timerAction() {
        
        if interval == .seconds {
            countDownSeconds()
        } else {
            nanosecond = nanosecond - 1
            if nanosecond == -1 {
                nanosecond = 9
                countDownSeconds()
            }
        }
        
        
        let time = MCCountdownStruct(day:day,hour:hour,minit:minit,second:second,nanosecond:nanosecond)
        delegate?.countdown(self, ongoingTime: time)
        
        if  nanosecond == 0 && second == 0 && minit == 0 && hour == 0 && day == 0 {
            mc_stopCountdown()
        }
    }
    
    
    // 对秒的倒计时
    private func countDownSeconds() {
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

    
    deinit {
        destructionTimer()
    }
}


extension MCCountdown {
    
    func openTimer() {
        
        guard let _ = timer else {
            timer = Timer.scheduledTimer(timeInterval: TimeInterval(interval.rawValue), target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            RunLoop.main.add(timer!, forMode: RunLoop.Mode.common)
            return
        }
    }
    
    // 销毁定时器
    private func destructionTimer() {
        timer?.invalidate()
        timer = nil
    }
}



public struct MCCountdownStruct {
    public var day        : Int
    public var hour       : Int
    public var minit      : Int
    public var second     : Int
    public var nanosecond : Int
}


