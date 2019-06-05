//
//  UIFont+Extension.swift
//  MCAPI
//
//  Created by MC on 2018/11/26.
//

import Foundation


extension UIFont {
    
    public static let mc8 = UIFont.mc_font(8)
    public static let mc9 = UIFont.mc_font(9)
    public static let mc10 = UIFont.mc_font(10)
    public static let mc11 = UIFont.mc_font(11)
    public static let mc12 = UIFont.mc_font(12)
    public static let mc13 = UIFont.mc_font(13)
    public static let mc14 = UIFont.mc_font(14)
    public static let mc15 = UIFont.mc_font(15)
    public static let mc16 = UIFont.mc_font(16)
    public static let mc17 = UIFont.mc_font(17)
    public static let mc18 = UIFont.mc_font(18)
    public static let mc19 = UIFont.mc_font(19)
    public static let mc20 = UIFont.mc_font(20)
    public static let mc21 = UIFont.mc_font(21)
    public static let mc22 = UIFont.mc_font(22)
    public static let mc23 = UIFont.mc_font(23)
    public static let mc24 = UIFont.mc_font(24)
    public static let mc25 = UIFont.mc_font(25)
    public static let mc26 = UIFont.mc_font(26)
    public static let mc27 = UIFont.mc_font(27)
    public static let mc28 = UIFont.mc_font(28)
    public static let mc29 = UIFont.mc_font(29)
    public static let mc30 = UIFont.mc_font(30)
    public static let mc31 = UIFont.mc_font(31)
    public static let mc32 = UIFont.mc_font(32)
    
    
    
    // 加粗
    public static let mcBold10 = UIFont.mc_boldFont(10)
    public static let mcBold11 = UIFont.mc_boldFont(11)
    public static let mcBold12 = UIFont.mc_boldFont(12)
    public static let mcBold13 = UIFont.mc_boldFont(13)
    public static let mcBold14 = UIFont.mc_boldFont(14)
    public static let mcBold15 = UIFont.mc_boldFont(15)
    public static let mcBold16 = UIFont.mc_boldFont(16)
    public static let mcBold17 = UIFont.mc_boldFont(17)
    public static let mcBold18 = UIFont.mc_boldFont(18)
    public static let mcBold19 = UIFont.mc_boldFont(19)
    public static let mcBold20 = UIFont.mc_boldFont(20)
    public static let mcBold21 = UIFont.mc_boldFont(21)
    public static let mcBold22 = UIFont.mc_boldFont(22)
    public static let mcBold23 = UIFont.mc_boldFont(23)
    public static let mcBold24 = UIFont.mc_boldFont(24)
    public static let mcBold25 = UIFont.mc_boldFont(25)
    public static let mcBold26 = UIFont.mc_boldFont(26)
    public static let mcBold27 = UIFont.mc_boldFont(27)
    public static let mcBold28 = UIFont.mc_boldFont(28)
    public static let mcBold29 = UIFont.mc_boldFont(29)
    public static let mcBold30 = UIFont.mc_boldFont(30)
    public static let mcBold31 = UIFont.mc_boldFont(31)
    public static let mcBold32 = UIFont.mc_boldFont(32)
    
    
    
    
    
    //字体
    public static func mc_font(_ font : CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: font)
    }
    
    public static func mc_boldFont(_ font : CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: font)
    }
    
}
