//
//  NormalSubViewController.swift
//  MCPageViewController_Example
//
//  Created by 满聪 on 2019/6/3.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

import MJRefresh
import SnapKit


protocol JumpToOtherIndex: NSObjectProtocol {
    func jumpToOtherIndex(_ index: Int)
}


class MCBasicUseSubViewController: UIViewController {
    
    public weak var delegate: JumpToOtherIndex?
    
    public var pageExplain = ""
    
    public var fatherViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = UIColor.clear
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: CGRect.zero, style: .plain)
        tb.backgroundColor = UIColor.clear
        tb.delegate = self
        tb.dataSource = self
        tb.separatorStyle = .none
        tb.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        return tb
    }()
}

extension MCBasicUseSubViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = UIColor.clear
//        if indexPath.row % 2 == 0 {
//            cell.backgroundColor = UIColor.white
//        } else {
//            cell.backgroundColor = UIColor.orange
//        }
        
        cell.textLabel?.text = pageExplain + "  第" + String(indexPath.row) + "行"
        cell.textLabel?.textColor = UIColor.black
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        delegate?.jumpToOtherIndex(6)
        
        let vc = NextViewController()
//
        self.fatherViewController?.navigationController?.pushViewController(vc, animated: true)
    }

}


extension MCBasicUseSubViewController {
    func initUI() {
        view.addSubview(tableView)
        tableView.snp.remakeConstraints { (make) ->Void in
            make.edges.equalTo(view)
        }
        
        
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                self.tableView.mj_header.endRefreshing()
            })
        })
        
        
        tableView.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                self.tableView.mj_footer.endRefreshing()
            })
        })
    }
}
