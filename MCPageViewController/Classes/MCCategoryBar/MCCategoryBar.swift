//
//  MCCategoryBar.swift
//  FLAnimatedImage
//
//  Created by 满聪 on 2019/4/25.
//

import UIKit
import SnapKit


public protocol MCCategoryBarDelegate: NSObjectProtocol {
    /// 点击了分类按钮
    func categoryBar(categoryBar: MCCategoryBar, didSelectItemAt index: Int)
}

public class MCCategoryBar: UIView {
    
    public weak var delegate: MCCategoryBarDelegate?
    
    public func initCategoryBarWithConfig(_ config: MCPageConfig) {
        categoryModels = config.categoryModels
        
        /// 检查配置
        if !isConfiguratioCorrect(config: config) {
            return
        }
        
        selectedIndex = MCPageConfig.shared.selectIndex

        initUI()

        collectionView.reloadData()
    }

    
    
    private var selectedIndex = 0
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    deinit {
        MCPageConfig.shared.empty()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
       
        
        MCPageConfig.shared.category.barHeight = self.frame.size.height

        
        
        collectionView.snp.remakeConstraints { (make) ->Void in
            make.top.bottom.equalTo(self)
            make.left.equalTo(MCPageConfig.shared.category.inset.left)
            make.right.equalTo(-MCPageConfig.shared.category.inset.right)

        }
        lineView.snp.remakeConstraints { (make) ->Void in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(0.5)
        }
        
        
        categoryBarDidClickItem(at: selectedIndex)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var categoryModels: [MCCategoryBarModel] = []
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = MCPageConfig.shared.category.itemSpacing
        
        let view = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
        view.backgroundColor = MCPageConfig.shared.category.barBackgroundColor
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        view.register(MCCategoryBarCell.classForCoder(), forCellWithReuseIdentifier: "MCCategoryCell")
        return view
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.MCPage_line
        return view
    }()
    
    private lazy var indicatorView: MCIndicatorView = {
        let view = MCIndicatorView()
        return view
    }()
}


extension MCCategoryBar {
    
    /// 检查配置
    private func isConfiguratioCorrect(config: MCPageConfig) -> Bool {
        if (config.categoryModels.count != config.viewControllers.count) ||
            config.categoryModels.count == 0 ||
            config.viewControllers.count == 0 {
            print("MCPageViewController:\n 请检查config的配置 config.vcs.count:\(config.categoryModels.count) --- config.vcs.count:\(config.viewControllers.count)")
            return false
        }
        
        if config.viewControllers.count <= config.selectIndex {
            print("MCPageViewController:\n 请检查config的配置config.selectIndex")
            return false
        }
        return true
    }
    
    func initUI() {

        self.addSubview(collectionView)

        self.addSubview(lineView)

        collectionView.addSubview(indicatorView)
    }
    
    
    /// 更改指示器的位置
    func updateIndicatorLocation(row: Int = 0) {
        
        if let cell = getCell(index: row) {
            let setWidth = MCPageConfig.shared.indicator.width
            
            let nameWidth = categoryModels[row].title.MCGetWidth(font: MCPageConfig.shared.category.selectFont, height: 30)
            
            
            let width = setWidth > 0 ? setWidth : nameWidth
            let height = MCPageConfig.shared.indicator.height
            
            let pointX = cell.frame.origin.x + cell.frame.size.width / 2
            let pointY = cell.frame.maxY
            
            indicatorView.center = CGPoint.init(x: pointX, y: pointY)
            indicatorView.bounds = CGRect.init(x: 0, y: 0, width: width, height: height)
        }
    }
    
    
    /// 更改选中的分类
    public func categoryBarDidClickItem(at itemIndex: Int) {
        
        if let selectedCell = self.getCell(index: self.selectedIndex) {
            selectedCell.isCategorySelected = false
        }

        
        if let targetCell = self.getCell(index: itemIndex) {
            targetCell.isCategorySelected = true
            self.selectedIndex = itemIndex;
            MCPageConfig.shared.selectIndex = self.selectedIndex
        }

        self.layoutAndScrollToSelectedItem(itemIndex)
        collectionView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.05) { [weak self] in
            self?.updateIndicatorLocation(row: itemIndex)
        }
    }
    
    
    /// 获取对应的cell
    func getCell(index: Int) -> MCCategoryBarCell? {
        return collectionView.cellForItem(at: IndexPath.init(row: index, section: 0)) as? MCCategoryBarCell
    }
    
    /// 滚动选中的item到中央位置
    func layoutAndScrollToSelectedItem(_ index: Int) {
        collectionView.scrollToItem(at: IndexPath.init(row: index, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
    }
}



extension MCCategoryBar: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryModels.count
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let config = MCPageConfig.shared
        let model = config.categoryModels[indexPath.row]
        
        let title = model.title

        let itemHeight: CGFloat = self.frame.size.height

        var itemWidth: CGFloat = config.category.itemExtendWidth + 2
        if indexPath.item == selectedIndex {
            itemWidth += title.getWidth(font: config.category.selectFont, height: 30)
        } else {
            itemWidth += title.getWidth(font: config.category.normalFont, height: 30)
        }
                
        return CGSize.init(width: itemWidth, height: itemHeight)
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MCCategoryCell", for: indexPath) as! MCCategoryBarCell
        
        let name = categoryModels[indexPath.row].title
        cell.titleLabel.text = name        
        cell.isCategorySelected = selectedIndex == indexPath.row ? true : false
        return cell
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        categoryBarDidClickItem(at: indexPath.row)
        delegate?.categoryBar(categoryBar: self, didSelectItemAt: indexPath.row)
    }
}





