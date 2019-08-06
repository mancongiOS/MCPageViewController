//
//  MCPhotoLibraryDetailCell.swift
//  MCComponentFunction_Example
//
//  Created by 满聪 on 2019/7/4.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

import MCComponentExtension
import Photos

class MCPhotoLibraryDetailCell: UICollectionViewCell {
    
    
    public var dataTuples: (isOpenBarrier: Bool, model: MCPhotoLibraryDetailModel) = (false, MCPhotoLibraryDetailModel()) {
        didSet {
            selectedIcon.isSelected = dataTuples.model.isSelected
            
            let width = UIScreen.main.bounds.size.width
            let collectionItemSize = CGSize.init(width: (width - 3) / 4, height: (width - 3) / 4)
            PHCachingImageManager.default().requestImage(for: dataTuples.model.asset, targetSize: collectionItemSize, contentMode: PHImageContentMode.aspectFill, options: nil) {[weak self] (image, nfo) in
                self?.imageView.image = image
            }
            
            
            
            let title = dataTuples.model.selectIndex == 0 ? "" : String(dataTuples.model.selectIndex)
            selectedIcon.setTitle(title, for: .normal)
            
            if dataTuples.isOpenBarrier && !dataTuples.model.isSelected {
                coverView.isHidden = false
            } else {
                coverView.isHidden = true
                
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(imageView)
        self.addSubview(selectedIcon)
        self.addSubview(coverView)
    }
    
    
    //播放动画，是否选中的图标改变时使用
    func playAnimate() {
        //图标先缩小，再放大
        UIView.animateKeyframes(withDuration: 0.4, delay: 0, options: .allowUserInteraction, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
                self.selectedIcon.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.4, animations: {
                self.selectedIcon.transform = CGAffineTransform.identity
            })
        }, completion: nil)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        selectedIcon.frame = CGRect.init(x: self.frame.size.width - 30, y: 2, width: 26, height: 26)
        coverView.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    lazy var selectedIcon: UIButton = {
        let button = UIButton.init(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.layer.cornerRadius = 13
        button.layer.masksToBounds = true
        button.setTitleColor(UIColor.white, for: .normal)
        
        let notSelImage = Bundle.mc_loadImage("image_not_selected", from: "MCPhotoLibraryBundle", in: "MCComponentFunction")
        button.setBackgroundImage(notSelImage, for: .normal)
        
        let titleColor = UIColor(red: 0x09/255, green: 0xbb/255, blue: 0x07/255, alpha: 1)
        button.setBackgroundImage(titleColor.mc_makeImage(), for: .selected)
        return button
    }()
    
    
    lazy var coverView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 1, alpha: 0.6)
        view.isHidden = true
        return view
    }()
}

