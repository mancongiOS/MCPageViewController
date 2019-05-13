//
//  ViewController.swift
//  MCPageViewController
//
//  Created by 562863544@qq.com on 01/22/2019.
//  Copyright (c) 2019 562863544@qq.com. All rights reserved.
//


import UIKit
import MJRefresh
import MCPageViewController


import SnapKit
class ViewController: UIViewController {
    
    
    /// 当前页面是否 不能滑动
    private var cannotScroll: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    
    lazy var tableView: MCBaseTableView = {
        let tb = MCBaseTableView.init(frame: CGRect.zero, style: .plain)
        tb.delegate = self
        tb.dataSource = self
        tb.separatorStyle = .none
        tb.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        return tb
    }()
    
    lazy var sectionHeader: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.frame = CGRect.init(x: 0, y: 0, width: 0, height: 400)
        return view
    }()
    
    lazy var sectionFooter: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.green
        view.frame = CGRect.init(x: 0, y: 0, width: 0, height: UIDevice.height - UIDevice.topSafeAreaHeight)
        return view
    }()
    
    
    lazy var pageViewController: MCPageViewController = {
        let pageViewController = MCPageViewController()
        pageViewController.delegate = self

        return pageViewController
    }()
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
}


extension ViewController {
    func initUI() {
        view.addSubview(tableView)
        tableView.snp.remakeConstraints { (make) ->Void in
            make.edges.equalTo(view)
        }
        

        
        tableView.tableHeaderView = sectionHeader
        tableView.tableFooterView = sectionFooter
        
        self.title = "页面联动";
        let titles = ["第0页第0页第0页","第1页","第2页","第3页","第4页","第5页","第6页","第7页","第8页","第9页","第10页"]
        
        
        let vcArrayM = NSMutableArray()
        let titleArrayM = NSMutableArray()
        
        
        
        
        for i in 0..<titles.count {
            let vc = SubViewController()
            vc.delegate = self
            vc.pageExplain = titles[i]
            vcArrayM.add(vc)
            
            let model = MCCategoryModel()
            model.title = titles[i]
            titleArrayM.add(model)
        }
        

        let config = MCPageConfig.shared
        config.categoryModels = titleArrayM as! [MCCategoryModel]
        config.viewControllers = vcArrayM as! [UIViewController]
        config.indicatorColor = UIColor.orange
        config.categoryBackgroundColor = UIColor.orange
        config.selectIndex = 0
        config.isShowMoreButton = true
        config.selectFont = UIFont.systemFont(ofSize: 19)
        config.categoryInset = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 5)
        

        

        self.addChild(pageViewController)
        self.sectionFooter.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.view.snp.remakeConstraints { (make) ->Void in
            make.edges.equalTo(sectionFooter)
        }
        

        
        pageViewController.initPagesWithConfig(config)
    }
}

extension ViewController: MCPageViewControllerDelegate {
    func pageViewControllerClickMoreEvent(_ pageViewController: MCPageViewController) {
        print("点击了更多按钮")
    }
    
    func pageViewControllerWillBeginDragging(_ pageViewController: MCPageViewController) {
        tableView.isScrollEnabled = false
    }
    
    
    
    func pageViewControllerDidEndDragging(_ pageViewController: MCPageViewController) {
        tableView.isScrollEnabled = true
    }
    
    func pageViewController(_ pageViewController: MCPageViewController, clickItemIndex index: Int) {
        print(index)
    }
}




extension ViewController: MCPageChildViewControllerDelegate {
    func pageChildViewControllerLeaveTop(_ childViewController: MCPageChildViewController) {
        cannotScroll = false
    }
}



extension ViewController {
    
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        return true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        //第二部分：处理scrollView滑动冲突
        let contentOffsetY = scrollView.contentOffset.y
        //吸顶临界点(此时的临界点不是视觉感官上导航栏的底部，而是当前屏幕的顶部相对scrollViewContentView的位置)
        let criticalPointOffsetY = scrollView.contentSize.height - UIDevice.height
        
        
        //利用contentOffset处理内外层scrollView的滑动冲突问题
        if (contentOffsetY >= criticalPointOffsetY) {
            /*
             * 到达临界点：
             * 1.未吸顶状态 -> 吸顶状态
             * 2.维持吸顶状态 (pageViewController.scrollView.contentOffsetY > 0)
             */
            //“进入吸顶状态”以及“维持吸顶状态”
            self.cannotScroll = true
            
            scrollView.contentOffset = CGPoint.init(x: 0, y: criticalPointOffsetY)

            pageViewController.currentChildPageViewController?.makePageViewControllerScroll(canScroll: true)
        } else {
            /*
             * 未达到临界点：
             * 1.维持吸顶状态 (pageViewController.scrollView.contentOffsetY > 0)
             * 2.吸顶状态 -> 不吸顶状态
             */
            if (self.cannotScroll) {
                //“维持吸顶状态”
                scrollView.contentOffset = CGPoint.init(x: 0, y: criticalPointOffsetY)
            } else {
                /* 吸顶状态 -> 不吸顶状态
                 * categoryView的子控制器的tableView或collectionView在竖直方向上的contentOffsetY小于等于0时，会通过代理的方式改变当前控制器self.canScroll的值；
                 */
            }
        }


        
    }
}







extension UIDevice {
    
    
    ///屏幕宽
    public static let width: CGFloat    = UIScreen.main.bounds.size.width
    
    ///屏幕高
    public static let height: CGFloat   = UIScreen.main.bounds.size.height
    
    ///状态栏高度
    public static let statusBarHeight: CGFloat   = UIApplication.shared.statusBarFrame.height
    
    /// tabbar的高度
    public static let tabBarHeight: CGFloat   = 49 + bottomSafeAreaHeight
    
    ///导航栏高度
    public static let navigationBarHeight: CGFloat = 44 + statusBarHeight
    
    /// 顶部安全区域的高度 (20 or 44)
    public static let topSafeAreaHeight: CGFloat   = UIDevice.safeAreaInsets().top
    
    /// 底部安全区域 (0 or 34)
    public static let bottomSafeAreaHeight: CGFloat  = UIDevice.safeAreaInsets().bottom
    
    
    private static func safeAreaInsets() -> (top: CGFloat, bottom: CGFloat) {
        if #available(iOS 11.0, *) {
            
            let inset = UIApplication.shared.delegate?.window??.safeAreaInsets
            
            return (inset?.top ?? 0, inset?.bottom ?? 0)
        } else {
            return (0, 0)
        }
    }
    
}
