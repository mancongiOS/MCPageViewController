//
//  MCAddOrReduceView.swift
//  MCComponentExtension
//
//  Created by MC on 2019/1/16.
//

import Foundation

import SnapKit
import MCComponentExtension

@objc public protocol MCAddOrReduceViewProtocol {
    @objc optional func delete()
    func changeQuantity(quantity:Int)
}


/**
 * 输入数量View
 */
public class MCAddOrReduceView: UIView {
    
    
    
    /// 当数量减为0的时候的，提示语(如果不赋值，则不弹出提示框)
    public var warningTextOfReduceToOne = ""
    
    public weak var delegate : MCAddOrReduceViewProtocol?
    
    
    /// 最大数量 默认100000件
    public var limitdedQuantity : Int = 100000
    
    // 当前数量
    public var currentQuantity : Int = 1 {
        didSet {
            quantityTextField.text = String(currentQuantity)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(addButton)
        self.addSubview(reduceButton)
        self.addSubview(quantityTextField)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        reduceButton.snp.remakeConstraints { (make) ->Void in
            make.width.equalTo(self.snp.height)
            make.left.top.bottom.equalTo(self)
        }
        
        addButton.snp.remakeConstraints { (make) ->Void in
            make.width.equalTo(self.snp.height)
            make.right.top.bottom.equalTo(self)
        }
        
        quantityTextField.snp.remakeConstraints { (make) ->Void in
            make.left.equalTo(reduceButton.snp.right).offset(1)
            make.right.equalTo(addButton.snp.left).offset(-1)
            make.top.bottom.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func changeButtonEvent(sender: UIButton) {
        if sender.tag == 1000 { // 减
            if currentQuantity <= 1 { // 是否删除购物车
                
                
                if warningTextOfReduceToOne.isEmpty {
                    return
                }
                UIAlertController.mc_confirm(title: warningTextOfReduceToOne, confirm: { (_) in
                    self.delegate?.delete?()
                }) 
                return
            }
            currentQuantity -= 1
        } else {  // 加
            currentQuantity += 1
        }
        
        // 是否超过最大限制数量（库存）
        if currentQuantity > limitdedQuantity {
            currentQuantity = limitdedQuantity
            MCLoading.text("最多可选\(limitdedQuantity)件")
            return
        }
        
        
        // 代理回去 执行修改数量的网络请求
        delegate?.changeQuantity(quantity: currentQuantity)
    }
    
    
    public lazy var quantityTextField: MCTextFiled = {
        let textField = MCTextFiled()
        textField.backgroundColor = UIColor.mc_line
        textField.textColor = UIColor.mc_gray
        textField.font = UIFont.mc12
        textField.textAlignment = NSTextAlignment.center
        textField.keyBoardType = MCKeyBorardType.Number
        textField.customDelegate = self
        textField.text = "1"
        return textField
    }()
    public lazy var reduceButton: UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        let image1 = Bundle.mc_loadImage("reduce", from: "MCComponentPublicUIViewBundle", in: "MCComponentPublicUI")
        button.setImage(image1, for: UIControl.State.normal)
        button.tag = 1000;
        button.addTarget(self, action: #selector(changeButtonEvent(sender:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    public lazy var addButton: UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        
        let image1 = Bundle.mc_loadImage("add", from: "MCComponentPublicUIViewBundle", in: "MCComponentPublicUI")

        button.setImage(image1, for: UIControl.State.normal)
        button.tag = 1001;
        button.addTarget(self, action: #selector(changeButtonEvent(sender:)), for: UIControl.Event.touchUpInside)
        return button
    }()
}


extension MCAddOrReduceView : MCTextFiledProlocol {
    public func MCTextFiled_cancel() {
        
    }
    
    public func MCTextFiled_done(text: String) {
        
        if text.count == 0 {
            quantityTextField.text = "1"
        }
        
        currentQuantity = quantityTextField.text!.intValue
        
        if currentQuantity < 1 {
            currentQuantity = 1
        }
        
        if currentQuantity > limitdedQuantity {
            currentQuantity = limitdedQuantity
            MCLoading.text("最多限购\(limitdedQuantity)件")
            return
        }
        
        // 代理 修改数量
        delegate?.changeQuantity(quantity: currentQuantity)
    }
}

