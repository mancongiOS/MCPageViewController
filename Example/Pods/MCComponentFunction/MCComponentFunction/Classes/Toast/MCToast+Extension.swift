//
//  MCToast+Extension.swift
//  GMJKExtension
//
//  Created by 满聪 on 2019/4/19.
//

import UIKit




extension MCToast {
    
    /// toast显示的时长
    public static let ktoastAutoClearTime: CGFloat = 2
    /// toast上文字的字体大小
    public static let kToastFont: CGFloat = 15

    

    
    /// 显示纯文字
    ///
    /// - Parameters:
    ///   - text: 文字内容
    ///   - autoClearTime: 自动隐藏时间，0即不隐藏
    ///   - font: 字体大小
    public static func mc_text(
        _ text: String,
        autoClearTime: CGFloat = ktoastAutoClearTime,
        font: CGFloat = kToastFont) {
        
        let autoClear : Bool = autoClearTime > 0 ? true : false
        MCToast.showText(text, autoClear: autoClear, autoClearTime: autoClearTime, font: font)
    }

    
    /// 显示一个loading
    ///
    /// - Parameters:
    ///   - text: 文字内容 默认为 "正在加载中"
    ///   - autoClearTime: 自动隐藏的时间
    ///   - font: 字体大小
    public static func mc_loading(
        text: String = "正在加载中",
        autoClearTime: CGFloat = 10,
        font: CGFloat = kToastFont) {

        let autoClear : Bool = autoClearTime > 0 ? true : false
        MCToast.loading(text: text, font: font, autoClear: autoClear, autoClearTime: autoClearTime)
    }
    
    
    
    
    /// 展示一个成功的toast
    ///
    /// - Parameters:
    ///   - text: 文字内容
    ///   - autoClearTime: 自动隐藏的时间
    ///   - font: 字体大小
    public static func mc_success(
        _ text:String,
        autoClearTime: CGFloat = ktoastAutoClearTime,
        font: CGFloat = kToastFont) {

        let autoClear : Bool = autoClearTime > 0 ? true : false
        MCToast.showNoticeWithText(.success, text: text, autoClear: autoClear, autoClearTime: autoClearTime, font: font)
    }
    
    
    
    /// 展示一个失败的的toast
    ///
    /// - Parameters:
    ///   - text: 文字内容
    ///   - autoClearTime: 自动隐藏的时间
    ///   - font: 字体大小
    public static func mc_failure(
        _ text: String,
        autoClearTime:CGFloat = ktoastAutoClearTime,
        font: CGFloat = kToastFont) {

        let autoClear : Bool = autoClearTime > 0 ? true : false
        MCToast.showNoticeWithText(.failure, text: text, autoClear: autoClear, autoClearTime: autoClearTime, font: font)
    }
    
    
    /// 展示一个等待的的toast
    ///
    /// - Parameters:
    ///   - text: 文字内容
    ///   - autoClearTime: 自动隐藏的时间
    ///   - font: 字体大小
    public static func mc_wait(
        _ text: String,
        autoClearTime:CGFloat = ktoastAutoClearTime,
        font: CGFloat = kToastFont) {
        
        let autoClear : Bool = autoClearTime > 0 ? true : false
        MCToast.showNoticeWithText(.wait, text: text, autoClear: autoClear, autoClearTime: autoClearTime, font: font)
    }

    
    
    /// 展示一个警告的的toast
    ///
    /// - Parameters:
    ///   - text: 文字内容
    ///   - autoClearTime: 自动隐藏的时间
    ///   - font: 字体大小
    public static func mc_warning(
        _ text: String,
        autoClearTime:CGFloat = ktoastAutoClearTime,
        font: CGFloat = kToastFont) {
        
        let autoClear : Bool = autoClearTime > 0 ? true : false
        MCToast.showNoticeWithText(.warning, text: text, autoClear: autoClear, autoClearTime: autoClearTime, font: font)
    }

   
    /// 展示一个其他的的toast
    ///
    /// - Parameters:
    ///   - text: 文字内容
    ///   - autoClearTime: 自动隐藏的时间
    ///   - font: 字体大小
    public static func mc_other(
        _ text: String,
        autoClearTime:CGFloat = ktoastAutoClearTime,
        font: CGFloat = kToastFont) {
        
        let autoClear : Bool = autoClearTime > 0 ? true : false
        MCToast.showNoticeWithText(.other, text: text, autoClear: autoClear, autoClearTime: autoClearTime, font: font)
    }

    
    
    /// 移除所有toast
    public static func mc_remove() {
        MCToast.clearAllToast()
    }
    
    /// 在状态栏栏显示一个toast
    ///
    /// - Parameters:
    ///   - text: 显示的文字内容
    ///   - autoClearTime: 自动隐藏的时间
    ///   - font: 字体大小
    public static func mc_statusBar(
        _ text: String,
        autoClearTime: CGFloat = ktoastAutoClearTime,
        font: CGFloat = kToastFont,
        backgroundColor: UIColor? = nil) {
        
        let autoClear : Bool = autoClearTime > 0 ? true : false
        MCToast.noticeOnStatusBar(text, autoClear: autoClear, autoClearTime: autoClearTime, backgroundColor: backgroundColor, font: font)
    }
    
}

