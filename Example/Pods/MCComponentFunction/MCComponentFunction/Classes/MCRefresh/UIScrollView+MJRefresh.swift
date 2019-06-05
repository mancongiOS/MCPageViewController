//
//  UIScrollView+MJRefresh.swift
//  Kingfisher
//
//  Created by 满聪 on 2019/5/24.
//

import Foundation


import MCComponentExtension
import MJRefresh


// TODO: - MJRefresh 方法封装
extension UIScrollView {
    
    /// 添加下拉刷新控件
    public func mc_header(refreshingBlock: @escaping (() -> ())) {
        self.mj_header = MJRefreshNormalHeader.init(refreshingBlock: refreshingBlock)
    }
    
    /// 停止下拉刷新
    public func mc_headerEnd() {
        self.mj_header.endRefreshing()
    }
    

    /// 添加上拉加载控件
    public func mc_footer(refreshingBlock: @escaping (() -> ())) {
        let footer = MJRefreshBackGifFooter.init(refreshingBlock: refreshingBlock)
        footer?.stateLabel.textColor = UIColor.mc_lightGray
        footer?.stateLabel.font = UIFont.mc15
        footer?.setTitle(" 已经到底了 ", for: .noMoreData)
        self.mj_footer = footer
    }
    
    /// 停止上拉加载
    public func mc_footerEnd() {
        
        self.mj_footer.endRefreshing()
    }
    
    /// 显示没有更多数据
    public func mc_footerNoMoreData() {
        self.mj_footer.endRefreshingWithNoMoreData()
    }
}

