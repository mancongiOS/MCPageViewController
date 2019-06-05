//
//  MCDatePickerPopupView.swift
//  MCAPI
//
//  Created by MC on 2018/8/30.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit

public class MCDatePickerPopupView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.6)

        let tap = UITapGestureRecognizer.init(target: self, action: #selector(cancelButtonClicked))
        self.addGestureRecognizer(tap)
        
        self.addSubview(bgView)
        bgView.addSubview(pickerView)
        bgView.addSubview(cancelButton)
        bgView.addSubview(sureButton)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        bgView.frame = CGRect.init(x: 0, y: self.bounds.size.height - 256, width: self.bounds.size.width, height: 256)
        pickerView.frame = CGRect.init(x: 0, y: 40, width: self.bounds.size.width, height: 216)
        cancelButton.frame = CGRect.init(x: 10, y: 7, width: 60, height: 26)
        sureButton.frame = CGRect.init(x: self.bounds.size.width - 70, y: 7, width: 60, height: 26)
        

    }
    
    
    private func MCHex(_ hex: String, _ alpha: CGFloat = 1.0) -> UIColor {
        if hex.isEmpty {
            return UIColor.clear
        }
        
        /** 传进来的值。 去掉了可能包含的空格、特殊字符， 并且全部转换为大写 */
        var hHex = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        /** 如果处理过后的字符串少于6位 */
        if hHex.count < 6 {
            return UIColor.clear
        }
        /** 开头是用0x开始的 */
        if hHex.hasPrefix("0X") {
            hHex = (hHex as NSString).substring(from: 2)
        }
        /** 开头是以＃开头的 */
        if hHex.hasPrefix("#") {
            hHex = (hHex as NSString).substring(from: 1)
        }
        /** 开头是以＃＃开始的 */
        if hHex.hasPrefix("##") {
            hHex = (hHex as NSString).substring(from: 2)
        }
        /** 截取出来的有效长度是6位， 所以不是6位的直接返回 */
        if hHex.count != 6 {
            return UIColor.clear
        }
        
        /** R G B */
        var range = NSMakeRange(0, 2)
        
        /** R */
        let rHex = (hHex as NSString).substring(with: range)
        
        /** G */
        range.location = 2
        let gHex = (hHex as NSString).substring(with: range)
        
        /** B */
        range.location = 4
        let bHex = (hHex as NSString).substring(with: range)
        
        /** 类型转换 */
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        
        Scanner(string: rHex).scanHexInt32(&r)
        Scanner(string: gHex).scanHexInt32(&g)
        Scanner(string: bHex).scanHexInt32(&b)
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }

    
    
    @objc func cancelButtonClicked() {
        self.removeFromSuperview()
    }
    
    @objc func sureButtonClicked() {
        self.removeFromSuperview()
    }
    
    @objc func emptyEvent() {}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(emptyEvent))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    public lazy var pickerView: MCDatePicker = {
        let p = MCDatePicker()
        
        //        p.minimumDate = MCDateManager_getDateFromString("2000-02-02")
        //        p.defaultDate = MCDateManager_getDateFromString("2003-02-02")
        //        p.maximumDate = MCDateManager_getDateFromString("2002-02-02")
        //
//        p.pickerView.showsSelectionIndicator = true

        // ---------->   设置时间的显示模式   <-------------//
        p.settingPickerView(mode: MCDateMode.year_month_day)
        return p
    }()

    public lazy var cancelButton: UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.layer.cornerRadius = 3
        button.layer.masksToBounds = true
        button.backgroundColor = MCHex("2075C6")
        button.setTitle("取消", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.alpha = 0.8
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
        return button
    }()
    
    public lazy var sureButton: UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.layer.cornerRadius = 3
        button.layer.masksToBounds = true
        button.backgroundColor = MCHex("2075C6")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitle("确定", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(sureButtonClicked), for: .touchUpInside)
        return button
    }()
}
