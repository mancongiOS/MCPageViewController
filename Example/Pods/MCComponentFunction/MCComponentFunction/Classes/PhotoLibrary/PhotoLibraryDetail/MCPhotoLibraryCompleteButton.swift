//
//  MCPhotoLibraryCompleteButton.swift
//  MCComponentFunction_Example
//
//  Created by 满聪 on 2019/7/4.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit


//照片选择页下方工具栏的“完成”按钮
class MCPhotoLibraryCompleteButton: UIView {
    
    
    //点击点击手势
    private var tapSingle:UITapGestureRecognizer?
    
    //设置数量
    public var num:Int = 0{
        didSet{
            if num == 0{
                numLabel.isHidden = true
            }else{
                numLabel.isHidden = false
                numLabel.text = "\(num)"
                playAnimate()
            }
        }
    }
    
    //是否可用
    public var isEnabled:Bool = true {
        didSet{
            if isEnabled {
                titleLabel.textColor = titleColor
                tapSingle?.isEnabled = true
            }else{
                titleLabel.textColor = UIColor.gray
                tapSingle?.isEnabled = false
            }
        }
    }
    
    //添加事件响应
    public func addTarget(target: Any?, action: Selector?) {
        //单击监听
        tapSingle = UITapGestureRecognizer(target:target,action:action)
        tapSingle!.numberOfTapsRequired = 1
        tapSingle!.numberOfTouchesRequired = 1
        self.addGestureRecognizer(tapSingle!)
    }
    
    
    init(){
        super.init(frame:defaultFrame)
        
        //已选照片数量标签初始化
        
        self.addSubview(numLabel)
        
        //按钮标题标签初始化
        self.addSubview(titleLabel)
    }
    
    //已选照片数量标签
    lazy var numLabel: UILabel = {
        let numLabel = UILabel(frame:CGRect(x: 0 , y: 0 , width: 20, height: 20))
        numLabel.backgroundColor = titleColor
        numLabel.layer.cornerRadius = 10
        numLabel.layer.masksToBounds = true
        numLabel.textAlignment = .center
        numLabel.font = UIFont.systemFont(ofSize: 15)
        numLabel.textColor = UIColor.white
        numLabel.isHidden = true
        return numLabel
    }()
    
    //按钮标题标签“完成”
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel(frame:CGRect(x: 20 , y: 0 ,
                                              width: defaultFrame.width - 20,
                                              height: 20))
        titleLabel.text = "完成"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = titleColor
        return titleLabel
    }()
    
    //按钮的默认尺寸
    let defaultFrame = CGRect.init(x: 0, y: 0, width: 70, height: 20)
    //文字颜色（同时也是数字背景颜色）
    let titleColor = UIColor(red: 0x09/255, green: 0xbb/255, blue: 0x07/255, alpha: 1)
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //用户数字改变时播放的动画
    func playAnimate() {
        //从小变大，且有弹性效果
        self.numLabel.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.5, options: UIView.AnimationOptions(),
                       animations: {
                        self.numLabel.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}

