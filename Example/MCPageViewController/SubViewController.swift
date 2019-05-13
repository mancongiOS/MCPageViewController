//
//  SubViewController.swift
//  MCPageViewController
//
//  Created by MC on 2018/11/5.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit
import MJRefresh


import MCPageViewController


import SnapKit
class SubViewController: MCPageChildViewController {
    
    public var pageExplain = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    
    lazy var tableView: UITableView = {
        let tb = UITableView.init(frame: CGRect.zero, style: .plain)
        tb.delegate = self
        tb.dataSource = self
        tb.separatorStyle = .none
        tb.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        return tb
    }()
}

extension SubViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = UIColor.white
        } else {
            cell.backgroundColor = UIColor.orange
        }
        
        cell.textLabel?.text = pageExplain + "  第" + String(indexPath.row) + "行"
        cell.textLabel?.textColor = UIColor.black
        
        return cell
    }
    
}


extension SubViewController {
    func initUI() {
        view.addSubview(tableView)
        tableView.snp.remakeConstraints { (make) ->Void in
            make.edges.equalTo(view)
        }
        
        
        tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                self.tableView.mj_header.endRefreshing()
            })
        })
        
        
        tableView.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                self.tableView.mj_footer.endRefreshing()
            })
        })
    }
}
