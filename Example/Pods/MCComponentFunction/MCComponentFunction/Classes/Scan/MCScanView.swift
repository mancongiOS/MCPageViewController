//
//  MCScanView.swift
//  Alamofire
//
//  Created by MC on 2018/12/25.
//

import UIKit
import MCComponentExtension


public class MCScanView: UIView {
    
    //屏幕扫描区域视图
    let barcodeView = UIView(frame: CGRect(x: UIScreen.main.bounds.size.width * 0.2, y: UIScreen.main.bounds.size.height * 0.35, width: UIScreen.main.bounds.size.width * 0.6, height: UIScreen.main.bounds.size.width * 0.6))
    //扫描线
    let scanLine = UIImageView()
    
    
    func beginAnimation() {
        
        timer.fireDate = Date.init()
    }
    
    func stopAnimation() {
        timer.fireDate = Date.distantFuture
    }
    
    func destroy() {
        timer.invalidate()
    }
    
    var timer = Timer()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        barcodeView.layer.borderWidth = 1.0
        barcodeView.layer.borderColor = UIColor.white.cgColor
        self.addSubview(barcodeView)
        
        //设置扫描线
        scanLine.frame = CGRect(x: 0, y: 0, width: barcodeView.frame.size.width, height: 1)
        
        let image = Bundle.mc_loadImage("Scan_scanning", from: "MCScanBundle", in: "MCComponentFunction")
        scanLine.image = image
        scanLine.contentMode = UIView.ContentMode.scaleAspectFit
        
        //添加扫描线图层
        barcodeView.addSubview(scanLine)
        
        self.createBackGroundView()
        
        
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(moveScannerLayer(_:)), userInfo: nil, repeats: true)
    }
    
    func  createBackGroundView() {
        let topView = UIView(frame: CGRect(x: 0, y: 0,  width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height * 0.35))
        let bottomView = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.width * 0.6 + UIScreen.main.bounds.size.height * 0.35, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height * 0.65 - UIScreen.main.bounds.size.width * 0.6))
        
        let leftView = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height * 0.35, width: UIScreen.main.bounds.size.width * 0.2, height: UIScreen.main.bounds.size.width * 0.6))
        let rightView = UIView(frame: CGRect(x: UIScreen.main.bounds.size.width * 0.8, y: UIScreen.main.bounds.size.height * 0.35, width: UIScreen.main.bounds.size.width * 0.2, height: UIScreen.main.bounds.size.width * 0.6))
        
        topView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        bottomView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        leftView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        rightView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        
        let label = UILabel(frame: CGRect(x: 0, y: 10, width: UIScreen.main.bounds.size.width, height: 21))
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.white
        label.text = "将二维码/条形码放入扫描框内，即自动扫描"
        
        bottomView.addSubview(label)
        
        
        self.addSubview(topView)
        self.addSubview(bottomView)
        self.addSubview(leftView)
        self.addSubview(rightView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //让扫描线滚动
    @objc func moveScannerLayer(_ timer : Timer) {
        scanLine.frame = CGRect(x: 0, y: 0, width: self.barcodeView.frame.size.width, height: 12);
        UIView.animate(withDuration: 2) {
            self.scanLine.frame = CGRect(x: self.scanLine.frame.origin.x, y: self.scanLine.frame.origin.y + self.barcodeView.frame.size.height - 10, width: self.scanLine.frame.size.width, height: self.scanLine.frame.size.height);
            
        }
        
    }
}
