//
//  MCPhotoLibraryDetailViewController.swift
//  MCComponentFunction_Example
//
//  Created by 满聪 on 2019/7/4.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Photos

class MCPhotoLibraryDetailViewController: UIViewController {
    // life cycle
    
    public var titleStr: String = ""
    
    public var maxSelected: Int = Int.max
    //照片选择完毕后的回调
    public var completeHandler:((_ images:[UIImage])->())?
    //数据源
    public var fetchResult: PHFetchResult<PHAsset> = PHFetchResult<PHAsset>()
    
    /// 是否开始展示遮挡层 (当选中数量 >= 最大可选中数量时候，开启)
    private var isOpenBarrier: Bool = false
    
    /// 记录当前选中所有的资源
    private var selectDataArray: [MCPhotoLibraryDetailModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseSetting()
        
        dealWithData()
        
        initUI()
    }
    
    // MARK: - Setter & Getter
    
    lazy var collectionItemSize = CGSize.init(width: (view.frame.size.width - 3) / 4, height: (view.frame.size.width - 3) / 4)
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = collectionItemSize
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
        let c = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        //        c.allowsSelection = true
        //        c.allowsMultipleSelection = true
        c.backgroundColor = UIColor.white
        c.delegate = self
        c.dataSource = self
        c.register(MCPhotoLibraryDetailCell.self, forCellWithReuseIdentifier: "cell")
        return c
    }()
    
    
    lazy var toolBar: UIToolbar = {
        let bar = UIToolbar()
        
        
        let size = self.view.frame.size
        bar.frame = CGRect.init(x: 0, y: size.height - 44 - UIDevice.bottomSafeAreaHeight, width: size.width, height: 44)
        return bar
    }()
    
    lazy var completeButton: MCPhotoLibraryCompleteButton = {
        let button = MCPhotoLibraryCompleteButton()
        button.isUserInteractionEnabled = true
        button.center = CGPoint(x: UIScreen.main.bounds.width - 50, y: 22)
        button.isEnabled = false
        button.addTarget(target: self, action: #selector(finishSelectEvent))
        return button
    }()
    
    
    lazy var dataArray: [MCPhotoLibraryDetailModel] = []
}

//MARK: 通知回调，闭包回调，点击事件
extension MCPhotoLibraryDetailViewController {
    @objc func cancelEvent() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //完成按钮点击
    @objc func finishSelectEvent() {
        
        //取出已选择的图片资源
        var images:[UIImage] = []
        
        for model in dataArray {
            if model.isSelected {
                images.append(model.asset.toImage())
            }
        }

        //调用回调函数
        self.navigationController?.dismiss(animated: true, completion: { [weak self] in
            self?.completeHandler?(images)
        })
    }
    
}


//MARK: 内部方法
extension MCPhotoLibraryDetailViewController {
    
    // 处理数据
    func dealWithData() {
        
        
        for i in 0..<fetchResult.count {
            let model = MCPhotoLibraryDetailModel()
            model.asset = fetchResult[i]
            dataArray.append(model)
        }
        
        collectionView.reloadData()
    }
    
    
    //获取已选择个数
    func getCollectionSelectedCount() -> Int {
        
        var count: Int = 0
        for model in dataArray {
            if model.isSelected {
                count += 1
            }
        }
        return count
    }
    
    // 显示提示框
    func showAlertView() {
        let title = "你最多只能选择\(self.maxSelected)张照片"
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title:"我知道了", style: .cancel, handler:nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // 修改完成按钮的状态
    func changeCompleteStatus(num: Int)  {
        
        completeButton.num = num
        if num == 0 {
            completeButton.isEnabled = false
        } else {
            completeButton.isEnabled = true
        }
    }
    
    // 选中了，改变状态
    func selectItem(_ cell: MCPhotoLibraryDetailCell, atRow indexPath: IndexPath, model: MCPhotoLibraryDetailModel) {
        
        model.isSelected = true
        //获取选中的数量
        let count = getCollectionSelectedCount()
        
        if count > self.maxSelected {
            //设置为不选中状态
            model.isSelected = false
            isOpenBarrier = true
            showAlertView()
        } else {
            model.isSelected = true
            model.selectIndex = count
            cell.playAnimate()
            
            //改变完成按钮数字
            changeCompleteStatus(num: count)
            
            if count == self.maxSelected {
                isOpenBarrier = true
            }
        }
        cell.dataTuples = (isOpenBarrier, model)
        
        
        if count == self.maxSelected {
            collectionViewReloadData()
        }
    }
    
    
    // 取消选中，改变状态
    func didDeselectItemAt(_ cell: MCPhotoLibraryDetailCell, atRow indexPath: IndexPath, model: MCPhotoLibraryDetailModel) {
        
        isOpenBarrier = false
        model.isSelected = false
        model.selectIndex = 0
        
        //获取选中的数量
        let count = getCollectionSelectedCount()
        changeCompleteStatus(num: count)

        collectionViewReloadData()
    }
    
    
    // 更新选中的标号数字,刷新collectionView
    func collectionViewReloadData() {
        
        var index = 0
        for model in dataArray {
            
            if model.isSelected {
                index += 1
                model.selectIndex = index                
            }
        }
        collectionView.reloadData()
    }
}

//MARK: UI的处理,通知的接收
extension MCPhotoLibraryDetailViewController {
    
    func baseSetting() {
        self.title = titleStr
        view.backgroundColor = UIColor.white
        
        let rightBarItem = UIBarButtonItem(title: "取消", style: .plain, target: self,action:#selector(cancelEvent))
        navigationItem.rightBarButtonItem = rightBarItem
    }
    
    func initUI() {
        collectionView.frame = view.frame
        view.addSubview(collectionView)
        view.addSubview(toolBar)
        
        let spaceItem = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let bar = UIBarButtonItem.init(customView: completeButton)
        toolBar.setItems([spaceItem, bar], animated: true)
    }
}

//MARK: 代理方法
extension MCPhotoLibraryDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MCPhotoLibraryDetailCell
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let model = dataArray[indexPath.row]
        
        cell.dataTuples = (isOpenBarrier, model)
        
        return cell
    }
    
    // 单元格点击响应
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath)
            as? MCPhotoLibraryDetailCell {
            
            let model = dataArray[indexPath.row]
                        
            if model.isSelected == true {
                didDeselectItemAt(cell, atRow: indexPath, model: model)
            } else {
                selectItem(cell, atRow: indexPath, model: model)
            }
        }

    }
}




extension UIDevice {
    
    /// 底部安全区域 (0 or 34)
    static let bottomSafeAreaHeight: CGFloat = UIDevice.safeAreaInsets().bottom
    
    private static func safeAreaInsets() -> (top: CGFloat, bottom: CGFloat) {
        if #available(iOS 11.0, *) {
            
            let inset = UIApplication.shared.delegate?.window??.safeAreaInsets
            
            let top = inset?.top ?? 0
            
            return (top == 0 ? 20 : top, inset?.bottom ?? 0)
        } else {
            return (20, 0)
        }
    }
}

extension PHAsset {
    func toImage() -> UIImage {
        
        var image = UIImage()
        
        // 新建一个默认类型的图像管理器imageManager
        let imageManager = PHImageManager.default()
        
        // 新建一个PHImageRequestOptions对象
        let imageRequestOption = PHImageRequestOptions()
        
        // PHImageRequestOptions是否有效
        imageRequestOption.isSynchronous = true
        
        // 缩略图的压缩模式设置为无
        imageRequestOption.resizeMode = .none
        
        // 缩略图的质量为高质量，不管加载时间花多少
        imageRequestOption.deliveryMode = .highQualityFormat
        
        // 按照PHImageRequestOptions指定的规则取出图片
        imageManager.requestImage(for: self, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFill, options: imageRequestOption, resultHandler: { (result, _) -> Void in
            image = result!
        })
        return image
        
    }
}

