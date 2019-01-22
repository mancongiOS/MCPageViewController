//
//  MCPageViewController.swift
//  MCPageViewController
//
//  Created by MC on 2018/11/2.
//  Copyright © 2018年 MC. All rights reserved.
//

import UIKit


open class MCPageViewController: UIViewController {
    
    /**
     * 根据数据直接创建
     */
    public func initPagesWithConfig(_ config: MCPageConfig) {
        settingWithConfig(config, items: nil)
    }
    
    /**
     * 自定义item样式
     */
    public func initCustomPageWithConfig(_ config: MCPageConfig,items: [MCPageItem]) {
        settingWithConfig(config, items: items)
    }
    
    /**
     * 跳转到某一个下标对应的控制器
     */
    public func jumpToSubViewController(_ index:Int) {
        
        if titleButtonArray.count > index {
            jumpToVC(btn: titleButtonArray[index])
        }
        
    }
    
    
    private var kSelfWidth : CGFloat = UIScreen.main.bounds.size.width
    private var kSelfHeight : CGFloat = UIScreen.main.bounds.size.height

    
    // MARK: - Setter & Getter
    private lazy var titleScrollView: UIScrollView = {
        let sv = UIScrollView.init()
        sv.showsHorizontalScrollIndicator = false
        sv.backgroundColor = UIColor.white
        return sv
    }()
    
    private lazy var indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = config.indicatorColor
        return view
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView.init()
        view.backgroundColor = UIColor.MCPage_light
        return view
    }()
    

    private lazy var titleButtonArray = [UIButton]()
    
    private lazy var pageVC: UIPageViewController = {
        let vc = UIPageViewController.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        vc.setViewControllers([config.vcs[0]],
                              direction: .reverse,
                              animated: false,
                              completion: nil)
        
        vc.delegate = self
        vc.dataSource = self
        return vc
    }()
    
    private lazy var config: MCPageConfig = {
        let c = MCPageConfig()
        return c
    }()
}

//MARK: 通知回调，闭包回调，点击事件
private extension MCPageViewController {
    @objc private func jumpToVC(btn:UIButton) {

        // 选中对应的button
        titleButtonClicked(btn: btn)
        
        let toPage = btn.tag - 1000
        let direction : UIPageViewController.NavigationDirection = config.defaultIndex > toPage ? .forward : .reverse
        
        pageVC.setViewControllers([config.vcs[toPage]], direction: direction, animated: false) { (finished) in
            self.config.defaultIndex = toPage;
        }
    }
    
    private func titleButtonClicked(btn:UIButton) {
        
        let tagNum = btn.tag
        config.defaultIndex = tagNum - 1000
        
        if config.defaultIndex < 0 {
            config.defaultIndex = 0
        }
        
        
        let title = config.titles[config.defaultIndex]
        let width = title.MCPageString_getWidth(font: config.blockFont, height: 20)
        
        for button in titleButtonArray {
            
            if tagNum != button.tag {
                button.setTitleColor(config.normalColor, for: .normal)
                button.titleLabel?.font = config.blockFont
            } else {
                UIView.animate(withDuration: 0.15, delay: 0.0, options: UIView.AnimationOptions.layoutSubviews, animations: {
                    self.indicatorView.center = CGPoint.init(x: button.center.x, y: self.config.barHeight - 0.75)
                    self.indicatorView.bounds = CGRect.init(x: 0, y: 0, width: width, height: 1.5)
                }) { (finished) in
                    self.indicatorView.bounds = CGRect.init(x: 0, y: 0, width: width, height: 1.5)
                    button.titleLabel?.font = self.config.selectedBlockFont
                    button.setTitleColor(self.config.selectedColor, for: .normal)
                }
            }
        }
        
        setScrollViewOffSet(btn: btn)
    }
}



//MARK: UI的处理,通知的接收
private extension MCPageViewController {
    
    private func settingWithConfig(_ config:MCPageConfig,items:[MCPageItem]?) {
       
        
        kSelfWidth = self.view.frame.width
        kSelfHeight = self.view.frame.height
        
        if (config.titles.count != config.vcs.count) || config.titles.count == 0 || config.vcs.count == 0 {
            print("MCPageViewController: 请检查config的配置 config.vcs.count:\(config.titles.count) --- config.vcs.count:\(config.vcs.count)")
            return
        }

        // 初始化配置
        self.config = config
        
        // 基础UI的处理
        initBaseUI()

        // 判断是否自定义UI
        if items == nil {
            default_initUI()
        } else {
            custom_initUI(items: items!)
        }
        
        jumpToSubViewController(config.defaultIndex)
    }
    
    
    
    // 基础UI的设置
    private func initBaseUI() {
        
        default_calculateBlockWidth()
        
        self.view.backgroundColor = UIColor.white

        titleScrollView.frame = CGRect.init(x: 0, y: 0, width: kSelfWidth, height: config.barHeight)
        titleScrollView.contentSize = CGSize.init(width: config.blockWidth * CGFloat(config.titles.count), height: 0)
        view.addSubview(titleScrollView)
        
        lineView.frame = CGRect.init(x: 0, y: config.barHeight, width: kSelfWidth, height: 1.5)
        view.addSubview(lineView)
        
        pageVC.view.frame = CGRect.init(x: 0, y: config.barHeight + 1, width: kSelfWidth, height: kSelfHeight - config.barHeight)
        view.addSubview(pageVC.view)
        
        
        let width = config.blockWidth * 0.8
        let indicatorView_x : CGFloat = (config.blockWidth - width)/2 + CGFloat(config.defaultIndex) * CGFloat(config.blockWidth)
        let indicatorView_y = config.barHeight - 1.5
        indicatorView.frame = CGRect.init(x: indicatorView_x, y: indicatorView_y, width: width, height: 1.5)
        indicatorView.isHidden = config.isHiddenIndicator
        titleScrollView.addSubview(indicatorView)
    }
    
    // 根据文字长度计算宽度
    private func default_calculateBlockWidth() {
        
        // 最长字符串的的宽度
        var maxW : CGFloat = 0.0;
        var allW : CGFloat = 0.0;
        
        for title in config.titles {
            let width = title.MCPageString_getWidth(font: config.blockFont, height: 20) + 10
            if width > maxW { maxW = width }
            allW += width;
        }
        
        // 看 MCPageConfig文件里面的blockWidth 的注释
        if config.blockWidth == 0 {
            if config.isLeftPosition {
                config.blockWidth = maxW
            } else {
                config.blockWidth = allW >= kSelfWidth ? maxW : (kSelfWidth / CGFloat(config.titles.count))
            }
        }
    }
}


private extension MCPageViewController {
    // 默认实现的UI配置
    private func default_initUI() {
        
        let arrayM = NSMutableArray()
        for i in 0..<config.titles.count {
            let btn = UIButton.init(type: .custom)
            btn.frame = CGRect.init(x: CGFloat(i)*config.blockWidth, y: 0, width: config.blockWidth, height: config.barHeight - 1.5)
            btn.backgroundColor = config.blockColor
            btn.titleLabel?.font = config.blockFont
            btn.setTitle(config.titles[i], for: .normal)
            
            btn.setTitleColor(config.normalColor, for: .normal)
            btn.setTitleColor(config.selectedColor, for: .selected)
            btn.tag = 1000 + i
            btn.addTarget(self, action: #selector(jumpToVC(btn:)), for: .touchUpInside)
            arrayM.add(btn)
            titleScrollView.addSubview(btn)
        }
        
        titleButtonArray = arrayM as! [UIButton]
    }
}

private extension MCPageViewController {
    private func custom_initUI(items: [UIButton]) {
        let arrayM = NSMutableArray()
        for i in 0..<items.count {
            
            let btn = items[i]
            
            btn.frame = CGRect.init(x: CGFloat(i)*config.blockWidth, y: 0, width: config.blockWidth, height: config.barHeight - 1.5)
            btn.backgroundColor = config.blockColor
            btn.titleLabel?.font = config.blockFont
            btn.setTitle(config.titles[i], for: .normal)
            
            btn.setTitleColor(config.normalColor, for: .normal)
            btn.setTitleColor(config.selectedColor, for: .selected)
            btn.tag = 1000 + i
            btn.addTarget(self, action: #selector(jumpToVC(btn:)), for: .touchUpInside)
            arrayM.add(btn)
            titleScrollView.addSubview(btn)
        }
        
        titleButtonArray = arrayM as! [UIButton]
    }
}


extension MCPageViewController : UIScrollViewDelegate,UIPageViewControllerDelegate,UIPageViewControllerDataSource {
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let index = config.vcs.index(of: viewController) ?? 0
        if index == config.vcs.count - 1 {
            return nil
        }
        return config.vcs[index + 1]
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let index = config.vcs.index(of: viewController) ?? 0
        if index == 0 {
            return nil
        }
        return config.vcs[index - 1]
    }

    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        let sub = pageViewController.viewControllers![0]
        var index = 0
        for subVc in config.vcs {
            if subVc.isEqual(sub) { config.defaultIndex = index }
            index += 1
        }
        
        
        let btn = view.window?.viewWithTag(config.defaultIndex + 1000) as! UIButton

        titleButtonClicked(btn: btn)
        
        setScrollViewOffSet(btn: btn)
    }
    
    private func setScrollViewOffSet(btn:UIButton) {
        
        if config.blockWidth * CGFloat(config.titles.count) < kSelfWidth {
            return
        }
        
        var count = kSelfWidth * 0.5 / config.blockWidth
        
        if count.truncatingRemainder(dividingBy: 2) == 0 { count -= 1 }
        
        var offsetX = btn.frame.origin.x - count * config.blockWidth
        
        if offsetX < 0 { offsetX = 0 }
        
        let maxOffsetX = titleScrollView.contentSize.width - kSelfWidth
        
        if offsetX > maxOffsetX { offsetX = maxOffsetX }
        
        UIView.animate(withDuration: 2) {
            self.titleScrollView.setContentOffset(CGPoint.init(x: offsetX, y: 0), animated: true)
        }
    }
}



