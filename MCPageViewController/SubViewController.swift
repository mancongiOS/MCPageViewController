//
//  SubViewController.swift
//  MCPageViewController
//
//  Created by MC on 2018/11/5.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit

protocol SubViewControllerProtocal : NSObjectProtocol {
    func jump(index:Int)
    func push()
}

class SubViewController: UIViewController {

    public var str = ""
    
    weak var delegate : SubViewControllerProtocal?
    
    let selfWidth = UIScreen.main.bounds.size.width
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        titleLabel.text = str
        view.addSubview(titleLabel)

        
        view.addSubview(jumpButton)
        view.addSubview(pushButton)
    }
    
    
    @objc func jumpButtonClicked() {
        delegate?.jump(index: 2)
    }

    @objc func pushButtonClicked() {
        delegate?.push()
    }

    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect.init(x: 10, y: 10, width: selfWidth - 20, height: 40)
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.MCPage_red
        return label
    }()

    lazy var jumpButton: UIButton = {
        let button = UIButton.init(type: UIButtonType.custom)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor.red
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitle("跳转第3页", for: .normal)
        button.frame = CGRect.init(x: 20, y: 200, width: selfWidth - 40, height: 40)
        button.addTarget(self, action: #selector(jumpButtonClicked), for: .touchUpInside)
        return button
    }()
    
    
    lazy var pushButton: UIButton = {
        let button = UIButton.init(type: UIButtonType.custom)
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor.red
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitle("导航跳转", for: .normal)
        button.frame = CGRect.init(x: 20, y: 260, width: selfWidth - 40, height: 40)
        button.addTarget(self, action: #selector(pushButtonClicked), for: .touchUpInside)

        return button
    }()

}
