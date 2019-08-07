//
//  MCCollectionView.swift
//  MCComponentExtension
//
//  Created by MC on 2019/1/15.
//

import Foundation
import UIKit


public class MCCollectionView: UICollectionView {
    
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
    
    override public init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.backgroundColor = UIColor.white
        self.emptyView.frame = frame
        self.backgroundView = self.emptyView
        
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


extension MCCollectionView {
    
    
    /// JKCollectionView的构造方法
    ///
    /// - Parameters:
    ///   - cell: 要注册的cell.type
    ///   - header: 要注册的header.type
    ///   - footer: 要注册的footer.type
    ///   - delegate: 代理
    ///   - layout: layout
    /// - Returns: JKCollectionView
    public static func mc_make<T: UICollectionViewCell, X: UICollectionReusableView> (
        registerCell cell: T.Type,
        registerHeader header: X.Type? = nil,
        registerFooter footer: X.Type? = nil,
        delegate: Any,
        layout: UICollectionViewFlowLayout
        ) -> MCCollectionView {
        
        
        let co = MCCollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        co.delegate = delegate as? UICollectionViewDelegate
        co.dataSource = delegate as? UICollectionViewDataSource
        co.showsHorizontalScrollIndicator = false
        co.showsVerticalScrollIndicator = false
        co.mc_registerCell(cell)
        
        if header != nil {
            co.mc_registerSectionHeader(header!)
        }
        
        if footer != nil {
            co.mc_registerSectionFooter(footer!)
        }
        
        return co
    }
}



extension MCCollectionView {
    /// 提前注册cell
    public func mc_registerCell<T: UICollectionViewCell>(_: T.Type) {
        self.register(T.self, forCellWithReuseIdentifier: getClassName(T.classForCoder()))
    }
    
    /// 提前注册SectionHeader
    public func mc_registerSectionHeader<T: UICollectionReusableView>(_: T.Type) {
        
        self.register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: getClassName(T.classForCoder()))
    }
    
    /// 提前注册SectionFooter
    public func mc_registerSectionFooter<T: UICollectionReusableView>(_: T.Type) {
        
        self.register(T.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: getClassName(T.classForCoder()))
    }
}


extension UICollectionView {
    
    /// 获取复用的cell
    public func mc_makeCell<T: UICollectionViewCell>(indexPath: IndexPath) -> T {
        let identifier = getClassName(T.classForCoder())
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T else {
            return T()
        }
        
        return cell
    }
    
    /// 获取复用的 SectionHeader
    public func mc_makeSectionHeader<T: UICollectionReusableView>(indexPath: IndexPath) -> T {
        let identifier = getClassName(T.classForCoder())
        
        guard let header = self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: identifier, for: indexPath) as? T else { return T() }
        return header
    }
    
    
    /// 获取复用的 SectionFooter
    public func mc_makeSectionFooter<T: UICollectionReusableView>(indexPath: IndexPath) -> T {
        let identifier = getClassName(T.classForCoder())
        
        guard let header = self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: identifier, for: indexPath) as? T else { return T() }
        return header
    }
    
}


private func getClassName(_ obj:Any) -> String {
    let mirro = Mirror(reflecting: obj)
    let className = String(describing: mirro.subjectType).components(separatedBy: ".").first!
    return className
}
