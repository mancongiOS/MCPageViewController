//
//  MCLoading+Extension.swift
//  
//
//  Created by MC on 2018/12/13.
//

import Foundation

extension MCLoading {
    
    /**
     * loading       提示框
     * @params       images 图片集合
     * @timeInterval 切换图片的时间间隔(ms)
     
     * 不传参数(用默认参数) 显示一个菊花loading
     */
    public static func loading(images:[UIImage] = [UIImage](),timeInterval:Int = 0) {
        
        MCLoading.wait(images, timeInterval: timeInterval)
    }
    
    
    /**
     * 显示纯文字
     * @params   text 显示的文案
     * @params   autoClearTime 显示的时长，如果autoClearTime <= 0 不自动清除
     * @params   font          文字的大小
     */
    public static func text(_ text:String, autoClearTime:CGFloat=2,font:CGFloat=14) {
        
        let autoClear : Bool = autoClearTime > 0 ? true : false
        
        MCLoading.showText(text, autoClear: autoClear, autoClearTime: autoClearTime, font: font)
    }
    
    
    /**
     * 成功的提示
     * @params   text 显示的文案
     * @params   autoClearTime 显示的时长，如果autoClearTime <= 0 不自动清除
     * @params   font          文字的大小
     */
    public static func success(_ text:String, autoClearTime:CGFloat=2,font:CGFloat=14) {
        
        let autoClear : Bool = autoClearTime > 0 ? true : false
        MCLoading.showNoticeWithText(.success, text: text, autoClear: autoClear, autoClearTime: autoClearTime,font: font)
    }
    
    /**
     * 失败的提示
     * @params   text 显示的文案
     * @params   autoClearTime 显示的时长，如果autoClearTime <= 0 不自动清除
     * @params   font          文字的大小
     */
    public static func failure(_ text:String, autoClearTime:CGFloat=2,font:CGFloat=14) {
        
        let autoClear : Bool = autoClearTime > 0 ? true : false
        MCLoading.showNoticeWithText(.error, text: text, autoClear: autoClear, autoClearTime: autoClearTime,font: font)
    }
    
    
    /**
     * 普通x消息的提示
     * @params   text 显示的文案
     * @params   autoClearTime 显示的时长，如果autoClearTime <= 0 不自动清除
     * @params   font          文字的大小
     */
    public static func info(_ text:String, autoClearTime:CGFloat=2,font:CGFloat=14) {
        let autoClear : Bool = autoClearTime > 0 ? true : false
        MCLoading.showNoticeWithText(.info, text: text, autoClear: autoClear, autoClearTime: autoClearTime,font: font)
    }
    
    
    /**
     * 关闭所有
     */
    public static func remove() {
        MCLoading.clear()
    }
    
    /**
     * 顶部状态栏消息的弹出
     * @params   text 显示的文案
     * @params   autoClearTime 显示的时长，如果autoClearTime <= 0 不自动清除
     * @params   font          文字的大小
     */
    public static func textOnStatusBar(_ text:String, autoClearTime:CGFloat=2,font:CGFloat=14) {
        let autoClear : Bool = autoClearTime > 0 ? true : false
        MCLoading.noticeOnStatusBar(text, autoClear: autoClear, autoClearTime: autoClearTime, font: font)
    }
    
}

