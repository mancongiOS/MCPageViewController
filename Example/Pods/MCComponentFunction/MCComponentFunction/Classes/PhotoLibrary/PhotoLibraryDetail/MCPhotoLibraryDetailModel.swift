//
//  MCPhotoLibraryDetailModel.swift
//  Alamofire
//
//  Created by 满聪 on 2019/7/4.
//

import UIKit

import Photos
class MCPhotoLibraryDetailModel: NSObject {
    
    /// 资源
    @objc var asset: PHAsset = PHAsset.init()
    
    /// 是否选中
    @objc var isSelected: Bool = false
    
    /// 第几个选中的
    @objc var selectIndex: Int = 0
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}

