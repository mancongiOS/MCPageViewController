//
//  MCCategoryBar.swift
//  FLAnimatedImage
//
//  Created by 满聪 on 2019/4/25.
//

import UIKit
import SnapKit


public protocol MCCategoryBarDelegate: NSObjectProtocol {
    func categoryBar(categoryBar: MCCategoryBar, didSelectItemAt index: Int)
    func categoryBarClickMoreEvent(categoryBar: MCCategoryBar)
}

public class MCCategoryBar: UIView {

    public weak var delegate: MCCategoryBarDelegate?
    
    public var categoryModels: [MCCategoryModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    
    private var selectedIndex = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
  
        self.backgroundColor = MCPageConfig.shared.barBackgroundColor
        initUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = MCPageConfig.shared.categoryItemSpacing
        flowLayout.sectionInset = MCPageConfig.shared.categoryInset
        
        let view = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = UIColor.white
        view.delegate = self
        view.dataSource = self
        view.register(MCCategoryCell.classForCoder(), forCellWithReuseIdentifier: "MCCategoryCell")
        return view
    }()
    
    
    public lazy var moreButton: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setImage(MCPageConfig.shared.moreImage, for: .normal)
        button.isHidden = !MCPageConfig.shared.isShowMoreButton
        button.addTarget(self, action: #selector(moreEvent(sender:)), for: .touchUpInside)
        button.backgroundColor = UIColor.white
        return button
    }()
    
    public lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.MCPage_line
        return view
    }()
}


extension MCCategoryBar {
    
    @objc func moreEvent(sender: UIButton) {
        delegate?.categoryBarClickMoreEvent(categoryBar: self)
    }
    
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if MCPageConfig.shared.isShowMoreButton {
            
            moreButton.snp.remakeConstraints { (make) ->Void in
                make.right.top.bottom.equalTo(self)
                make.width.equalTo(self.snp.height)
            }
            
            
            collectionView.snp.remakeConstraints { (make) ->Void in
                make.left.top.bottom.equalTo(self)
                make.right.equalTo(moreButton.snp.left)
            }
        } else {
            collectionView.snp.remakeConstraints { (make) ->Void in
                make.edges.equalTo(self)
            }
        }
        
        lineView.snp.remakeConstraints { (make) ->Void in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(1)
        }

    }
    
    func initUI() {
        
        
        if MCPageConfig.shared.isShowMoreButton {
            
            self.addSubview(moreButton)
            self.addSubview(collectionView)
        } else {
            self.addSubview(collectionView)
        }
        
        self.addSubview(lineView)
        lineView.snp.remakeConstraints { (make) ->Void in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(0.5)
        }
    }
}



extension MCCategoryBar: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryModels.count
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // 最多显示5个字
        
        
        var name = MCPageConfig.shared.categoryModels[indexPath.row].title
        
        name = name.MCClipFromPrefix(to: MCPageConfig.shared.maxTitleCount)
        

        
        let width =  name.getWidth(font: MCPageConfig.shared.selectFont, height: 30) + 10
        return CGSize.init(width: width, height: 50)
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MCCategoryCell", for: indexPath) as! MCCategoryCell
        
        var name = categoryModels[indexPath.row].title
        
        name = name.MCClipFromPrefix(to: MCPageConfig.shared.maxTitleCount)
        
        cell.titleLabel.text = name
        cell.backgroundColor = MCPageConfig.shared.categoryBackgroundColor
        
        cell.isCategorySelected = selectedIndex == indexPath.row ? true : false
        return cell
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        changeItemWithTargetIndex(targetIndex: indexPath.row)
        delegate?.categoryBar(categoryBar: self, didSelectItemAt: indexPath.row)
    }
    
    
    
    public func changeItemWithTargetIndex(targetIndex: Int) {
        
        if (self.selectedIndex == targetIndex) {
            return;
        }
        
        if let selectedCell = getCell(index: selectedIndex) {
            selectedCell.isCategorySelected = false
        }

        
        if let targetCell = getCell(index: targetIndex) {
            targetCell.isCategorySelected = true
        }
        
        
        self.selectedIndex = targetIndex;
        
        layoutAndScrollToSelectedItem()
    }
    
    func getCell(index: Int) -> MCCategoryCell? {
        return collectionView.cellForItem(at: IndexPath.init(row: index, section: 0)) as? MCCategoryCell
    }
    
    func layoutAndScrollToSelectedItem() {
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.setNeedsLayout()
        collectionView.layoutIfNeeded()
        
        collectionView.scrollToItem(at: IndexPath.init(row: selectedIndex, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
    }
}



public class MCCategoryModel: NSObject {
    @objc public var title: String = ""
    
    
    override public func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}



public class MCCategoryCell: UICollectionViewCell {
    
    public var isCategorySelected: Bool = false {
        didSet {
            if isCategorySelected {
                titleLabel.textColor = MCPageConfig.shared.selectedColor
                titleLabel.font = MCPageConfig.shared.selectFont
            } else {
                titleLabel.textColor = MCPageConfig.shared.normalColor
                titleLabel.font = MCPageConfig.shared.normalFont
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.remakeConstraints { (make) ->Void in
            make.edges.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
}
