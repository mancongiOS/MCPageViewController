//
//  MCTableView.swift
//  MCComponentExtension
//
//  Created by MC on 2019/1/15.
//

import Foundation


public class MCTableView: UITableView {
    
    
    /// 当前tableView的数据源，如果为0的话，展示空数据页面。否则隐藏。
    public var dataListCount: Int = 0 {
        didSet {
            if dataListCount == 0 {
                showBackground()
            } else {
                hideBackground()
            }
        }
    }
    
    
    override public init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.backgroundColor = UIColor.white
        self.emptyView.frame = frame
        self.backgroundView = self.emptyView
        
        self.estimatedRowHeight = 0
        self.estimatedSectionFooterHeight = 0
        self.estimatedSectionHeaderHeight = 0
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    /**
     * 展示背景  空数据UI展示
     */
    public func showBackground() {
        self.emptyView.isHidden = false
    }
    
    /**
     * 隐藏背景  空数据UI隐藏
     */
    public func hideBackground() {
        self.emptyView.isHidden = true
    }
    
    public lazy var emptyView: MCEmptyDataView = {
        let view = MCEmptyDataView()
        view.isHidden = true
        return view
    }()
}

extension MCTableView {
    
    
    /// JKTableView的构建方法
    ///
    /// - Parameters:
    ///   - cell: 要注册的cell
    ///   - delegate: 遵循代理
    ///   - style: plain & grouped
    /// - Returns: JKTableView
    public static func mc_make <T: UITableViewCell,X: UIView> (
        registerCell cell: T.Type,
        registerHeader header: X.Type? = nil,
        registerFooter footer: X.Type? = nil,
        delegate: Any,
        style: UITableView.Style = .plain) -> MCTableView {
        let tb = MCTableView.init(frame: .zero, style: style)
        tb.delegate = delegate as? UITableViewDelegate
        tb.dataSource = delegate as? UITableViewDataSource
        tb.mc_register(cell)
        
        if header != nil {
            tb.mc_registerSectionHeader(header!)
        }
        
        if footer != nil {
            tb.mc_registerSectionFooter(footer!)
        }
        
        return tb
    }
}



extension UITableView {
    /// 提前注册cell
    func mc_register<T: UITableViewCell>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: getClassName(T.classForCoder()))
    }
    
    /// 提前注册sectionHeader
    func mc_registerSectionHeader<T: UIView>(_: T.Type) {
        let identifier = getClassName(T.classForCoder())
        register(T.self, forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    /// 提前注册sectionFooter
    func mc_registerSectionFooter<T: UIView>(_: T.Type) {
        let identifier = getClassName(T.classForCoder())
        register(T.self, forHeaderFooterViewReuseIdentifier: identifier)
    }
}

extension UITableView {
    
    /// 获取cell
    public func mc_makeCell<T: UITableViewCell>(indexPath: IndexPath) -> T {
        let identifier = getClassName(T.classForCoder())
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            return T()
        }
        return cell
    }
    
    /// 获取复用的 SectionHeader
    public func mc_makeSectionHeader<T: UITableViewHeaderFooterView>(_: T.Type) -> T {
        let identifier = getClassName(T.classForCoder())
        guard let header = dequeueReusableHeaderFooterView(withIdentifier: identifier)  as? T else { return T() }
        return header
    }
    
    /// 获取复用的 SectionFooter
    public func mc_makeSectionFooter<T: UITableViewHeaderFooterView>(_: T.Type) -> T {
        let identifier = getClassName(T.classForCoder())
        guard let footer = dequeueReusableHeaderFooterView(withIdentifier: identifier)  as? T else { return T() }
        return footer
    }
    
}


fileprivate func getClassName(_ obj:Any) -> String {
    let mirro = Mirror(reflecting: obj)
    let className = String(describing: mirro.subjectType).components(separatedBy: ".").first!
    return className
}
