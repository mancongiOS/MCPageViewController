//
//  ViewController.swift
//  MCPageViewController
//
//  Created by 562863544@qq.com on 01/22/2019.
//  Copyright (c) 2019 562863544@qq.com. All rights reserved.
//



/**
 继续需要完善的地方
 1. 分类栏分类是否居中展示
 2. MCIndicatorView需要重新完善动画效果。
 3. 更新完整的readMe文件，录制一个使用的gif。
 */


import UIKit
import MJRefresh
import MCPageViewController
import MCComponentExtension
import MCComponentFunction
import MCComponentPublicUI



import SnapKit

class ViewController: UIViewController {
    // life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseSetting()
        
        initUI()
        
    }
    
    // MARK: - Setter & Getter
    lazy var tableView = MCTableView.mc_make(registerCell: UITableViewCell.self, delegate: self)
    
    lazy var dataArray: [String] = []
}


//MARK: UI的处理,通知的接收
extension ViewController {
    
    func baseSetting() {
        self.title = "示例"
        dataArray = [
            "基本使用 - 简单示例",
            "基本使用 - 分类栏属性设置",
            "基本使用 - 分割线的设置",
            "基本使用 - 设置分类栏的左右控件",
            "基本使用 - 分类栏在导航栏上",
            "基本使用 - 指示器的设置",

            "高级使用 - 滑动悬停分类栏（无导航栏）",
            "高级使用 - 滑动悬停分类栏（有导航栏）",
            "高级使用 - 多级页面"
        ]
    }
    
    func initUI() {
        view.addSubview(tableView)
        tableView.snp.remakeConstraints { (make) ->Void in
            make.edges.equalTo(view)
        }
    }
}

//MARK: 代理方法
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = MCTool.mc_getClassName(UITableViewCell.self)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row]
        
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.mc_backgroud
        } else {
            cell.backgroundColor = UIColor.white
        }
    
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            let vc = MCBasicUseOneViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = MCBasicUseTwoViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = MCBasicUseThreeViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = MCBasicUseFourViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 4:
            let vc = MCBasicUseFiveViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 5:
            let vc = MCBasicUseSixViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 6:
            let vc = MCSlidingSuspensionViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 7:
            let vc = MCSlidingSuspensionTwoViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 8:
            let vc = MCThreeLevelViewController()
            navigationController?.pushViewController(vc, animated: true)

            


           
        default:
            break
        }
    }
}
