//
//  UIImagePickerController+Extension .swift
//  Alamofire
//
//  Created by MC on 2018/12/10.
//

import Foundation
import UIKit
import Photos

/// 相片选择器类型：相册 PhotoLibrary，图库 SavedPhotosAlbum，相机 Camera，前置摄像头 Front，后置摄像头 Rear
public enum UIImagePickerType:Int {
    /// 相册 PhotoLibrary
    case UIImagePickerTypePhotoLibrary = 1
    /// 图库 SavedPhotosAlbum
    case UIImagePickerTypeSavedPhotosAlbum = 2
    /// 相机 Camera
    case UIImagePickerTypeCamera = 3
    /// 前置摄像头 Front
    case UIImagePickerTypeCameraFront = 4
    /// 后置摄像头 Rear
    case UIImagePickerTypeCameraRear = 5
}

extension UIImagePickerController {
    // MARK: - 设备使用有效性判断
    // 相册 PhotoLibrary，图库 SavedPhotosAlbum，相机 Camera，前置摄像头 Front，后置摄像头 Rear
    public class func isValidImagePickerType(type imagePickerType:UIImagePickerType) -> Bool {
        switch imagePickerType {
        case .UIImagePickerTypePhotoLibrary:
            if self.isValidPhotoLibrary {
                return true
            }
            return false
        case .UIImagePickerTypeSavedPhotosAlbum:
            if self.isValidSavedPhotosAlbum {
                return true
            }
            return false
        case .UIImagePickerTypeCamera:
            if self.isValidCameraEnable && self.isValidCamera {
                return true
            }
            return false
        case .UIImagePickerTypeCameraFront:
            if self.isValidCameraEnable && self.isValidCameraFront {
                return true
            }
            return false
        case .UIImagePickerTypeCameraRear:
            if self.isValidCamera && self.isValidCameraRear {
                return true
            }
            return false
        }
    }
    
    /// 相机设备是否启用
    public class var isValidCameraEnable:Bool{
        get {
            let cameraStatus =
                AVCaptureDevice.authorizationStatus(for: AVMediaType.audio)
            if cameraStatus == AVAuthorizationStatus.denied {
                return false
            }
            return true
        }
    }
    
    /// 相机Camera是否可用（是否有摄像头）
    public class var isValidCamera:Bool{
        get {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
                return true
            }
            return false
        }
    }
    
    /// 前置相机是否可用
    public class var isValidCameraFront:Bool{
        get {
            if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerController.CameraDevice.front){
                return true
            }
            return false
        }
    }
    
    /// 后置相机是否可用
    public class var isValidCameraRear:Bool{
        get {
            if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerController.CameraDevice.rear){
                return true
            }
            return false
        }
    }
    
    /// 相册PhotoLibrary是否可用
    public class var isValidPhotoLibrary:Bool{
        get {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
                return true
            }
            return false
        }
    }
    
    /// 图库SavedPhotosAlbum是否可用
    public class var isValidSavedPhotosAlbum:Bool {
        get {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.savedPhotosAlbum) {
                return true
            }
            return false
        }
    }
    
    
    // MARK: - 属性设置
    public func setImagePickerStyle(bgroundColor:UIColor?, titleColor:UIColor?, buttonTitleColor:UIColor?) {
        // 改navigationBar背景色
        if let bgroundColorTmp:UIColor = bgroundColor {
            self.navigationBar.barTintColor = bgroundColorTmp
        }
        
        // 改navigationBar标题色
        if let titleColorTmp:UIColor = titleColor {
            self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColorTmp]
        }
        
        // 改navigationBar的button字体色
        if let buttonTitleColorTmp:UIColor = buttonTitleColor {
            self.navigationBar.tintColor = buttonTitleColorTmp
        }
    }
}
