//
//  MCPhotoLibraryListViewController.swift
//  MCComponentFunction_Example
//
//  Created by 满聪 on 2019/7/4.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Photos


//相簿列表项
struct MCPhotoLibraryItem {
    //相簿名称
    var title: String?
    //相簿内的资源
    var fetchResult: PHFetchResult<PHAsset>
}


class MCPhotoLibraryListViewController: UIViewController {
    
    //每次最多可选择的照片数量
    public var maxSelected:Int = Int.max
    
    //照片选择完毕后的回调
    public var completeHandler:((_ images:[UIImage])->())?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        getAssetCollection()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseSetting()
        
        initUI()
    }
    
    // MARK: - Setter & Getter
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: CGRect.zero, style: .plain)
        tb.delegate = self
        tb.dataSource = self
        tb.separatorStyle = .none
        return tb
    }()
    
    lazy var dataArray: [MCPhotoLibraryItem] = []
}

//MARK: 通知回调，闭包回调，点击事件
extension MCPhotoLibraryListViewController {
    @objc func cancelEvent() {
        self.dismiss(animated: true, completion: nil)
    }
}


//MARK: 内部方法
extension MCPhotoLibraryListViewController {
    
    // 开始获取相册资源
    func getAssetCollection() {
        //申请权限
        PHPhotoLibrary.requestAuthorization({ [weak self] (status) in
            
            if status != .authorized { return }
            
            // 列出所有系统的智能相册
            let smartOptions = PHFetchOptions()
            let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: smartOptions)
            self?.convert(collection: smartAlbums)
            
            //列出所有用户创建的相册
            let userCollections = PHCollectionList.fetchTopLevelUserCollections(with: nil)
            self?.convert(collection: userCollections as! PHFetchResult<PHAssetCollection>)
            
            //相册按包含的照片数量排序（降序）
            self?.dataArray.sort { (item1, item2) -> Bool in
                return item1.fetchResult.count > item2.fetchResult.count
            }
            
            //异步加载表格数据,需要在主线程中调用reloadData() 方法
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                
                // 首次直接进入相机胶卷
                if let item = self?.dataArray.first {
                    self?.jumpToPhotoLibraryDetailViewController(item: item, animated: false)
                }
            }
        })
    }
    
    
    // 将获取的资源 转为 MCPhotoLibraryItem类型方便使用
    private func convert(collection: PHFetchResult<PHAssetCollection>) {
        
        for i in 0..<collection.count {
            //获取出当前相簿内的图片
            let resultsOptions = PHFetchOptions()
            
            resultsOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate",ascending: false)]
            
            resultsOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
            
            let c = collection[i]
            let assetsFetchResult = PHAsset.fetchAssets(in: collection[i], options: resultsOptions)
            
            //没有图片的空相簿不显示
            if assetsFetchResult.count > 0 {
                let title = translateIntoChineseBy(title: c.localizedTitle)
                dataArray.append(MCPhotoLibraryItem(title: title, fetchResult: assetsFetchResult))
            }
        }
    }

    
    //由于系统返回的相册集名称为英文，需要转换为中文
    private func translateIntoChineseBy(title: String?) -> String? {
        if title == "Slo-mo" {
            return "慢动作"
        } else if title == "Recently Added" {
            return "最近添加"
        } else if title == "Favorites" {
            return "个人收藏"
        } else if title == "Recently Deleted" {
            return "最近删除"
        } else if title == "Videos" {
            return "视频"
        } else if title == "All Photos" {
            return "所有照片"
        } else if title == "Selfies" {
            return "自拍"
        } else if title == "Screenshots" {
            return "屏幕快照"
        } else if title == "Camera Roll" {
            return "相机胶卷"
        }
        return title
    }
    
    // 进入详情页面
    func jumpToPhotoLibraryDetailViewController(item: MCPhotoLibraryItem, animated: Bool = true) {
        let vc = MCPhotoLibraryDetailViewController()
        vc.titleStr = item.title ?? ""
        vc.fetchResult = item.fetchResult
        vc.maxSelected = maxSelected
        vc.completeHandler = self.completeHandler
        navigationController?.pushViewController(vc, animated: animated)
    }
}

//MARK: UI的处理,通知的接收
extension MCPhotoLibraryListViewController {
    
    func baseSetting() {
        self.title = "相簿"
        let rightBarItem = UIBarButtonItem(title: "取消", style: .plain, target: self,action:#selector(cancelEvent))
        navigationItem.rightBarButtonItem = rightBarItem
    }
    
    func initUI() {
        tableView.frame = view.frame
        view.addSubview(tableView)
    }
}

//MARK: 代理方法
extension MCPhotoLibraryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let photoLibraryItem = dataArray[indexPath.row]

        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if cell == nil {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: "cell")
        }
        
        cell?.selectionStyle = .none
        cell?.accessoryType = .disclosureIndicator
        cell?.textLabel?.text = photoLibraryItem.title
        cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
        cell?.detailTextLabel?.text = String(photoLibraryItem.fetchResult.count)
        

        let lineView = UIView()
        lineView.backgroundColor = UIColor.groupTableViewBackground
        lineView.frame = CGRect.init(x: 10, y: 59, width: view.frame.size.width - 20, height: 1)
        cell?.contentView.addSubview(lineView)
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = dataArray[indexPath.row]
        jumpToPhotoLibraryDetailViewController(item: item)
    }
}

