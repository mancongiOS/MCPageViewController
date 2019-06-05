//
//  MCCountdownButton.swift
//  MCComponentExtension
//
//  Created by MC on 2019/1/30.
//

import Foundation

import UIKit

import MCComponentExtension


@objc public protocol MCCountDownButtonProtocol {
    /// 开始倒计时
    @objc optional func startCountDown()
    /// 结束倒计时
    @objc optional func endCountDown()
    /// 倒计时中
    @objc optional func countDowning(count: Int)
}

// 倒计时按钮

public class MCCountDownButton: UIButton {
    
    private var timer : Timer? = nil
    
    public var seconds : Int = 60 {
        didSet {
            count = seconds
        }
    }
    
    private var count : Int = 60
    
    public weak var delegate : MCCountDownButtonProtocol?
    
    /// 校验完成成功，准备请求接口发送短信
    public var canRequest : Bool = false {
        didSet {
            if canRequest == true && isRequestSuccess == true {
                timeCutdown()
            }
        }
    }
    
    /// 发送完短信成功，开始倒计时
    public var isRequestSuccess : Bool = false {
        didSet {
            if canRequest == true && isRequestSuccess == true {
                timeCutdown()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setTitleColor(UIColor.mc_hex(hex: "2F7CFF"), for: .normal)
        
        setTitle("获取验证码", for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        addTarget(self, action: #selector(clickedEvent), for: .touchUpInside)
        isEnabled = true
    }
    
    
    @objc public func clickedEvent() {
        // 点击了倒计时按钮，在外部开始对 canRequest 和 isRequestSuccess。开启倒计时
        delegate?.startCountDown?()
    }
    
    @objc private func timeCutdown() {
        
        if timer == nil {
            timer = Timer(timeInterval: 1.0, target: self, selector: #selector(buttonChanged), userInfo: nil, repeats: true)
            timer?.fire()
            RunLoop.main.add(timer!, forMode: RunLoop.Mode.common)
        }
    }
    
    @objc private func buttonChanged() {
        
        count -= 1
        if count < 0 {
            
            timer?.invalidate()
            timer = nil
            count = seconds
            setTitle("获取验证码", for: .normal)
            
            setTitleColor(UIColor.mc_hex(hex: "2F7CFF"), for: .normal)
            
            isEnabled = true
            // 结束倒计时
            delegate?.endCountDown?()
            return
        }
        
        
        
        isEnabled = false
        setTitle("\(count)s后重新发送", for: .normal)
        setTitleColor(UIColor.gray, for: .normal)
        delegate?.countDowning?(count: count)
        
        
    }
    
    deinit {
        if timer != nil {
            if timer!.isValid {
                timer?.invalidate()
                timer = nil
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
