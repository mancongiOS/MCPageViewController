//
//  MCScanViewController.swift
//  Alamofire
//
//  Created by MC on 2018/12/25.
//

import UIKit

import AVFoundation
import MCComponentExtension

public protocol MCScanViewControllerDelegate : NSObjectProtocol {
    func scanResult(str: String)
}

public class MCScanViewController: UIViewController {
    
    
    public weak var delegate : MCScanViewControllerDelegate?
    var device:AVCaptureDevice!
    var input:AVCaptureDeviceInput!
    var output:AVCaptureMetadataOutput!
    var session:AVCaptureSession!
    var preview:AVCaptureVideoPreviewLayer!
    let captureSession = AVCaptureSession()
    
    
    public init(_ dict: [String: Any]) {
        super.init(nibName: nil, bundle: nil)
        delegate = dict["delegate"] as? MCScanViewControllerDelegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        baseSetting()
    
        initUI()
    
        setCaptureWindow()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.scannerStart()
    }

    
    lazy var cameraView: MCScanView = {
        let view = MCScanView()
        view.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        return view
    }()
    
    
    lazy var backButton: UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect.init(x: 15, y: UIApplication.shared.statusBarFrame.size.height, width: 44, height: 44)
        
        let image = Bundle.mc_loadImage("Scan_back", from: "MCScanBundle", in: "MCComponentFunction")
        
        button.setImage(image, for: .normal)
        
        button.imageEdgeInsets = UIEdgeInsets.init(top: 12, left: 15, bottom: 12, right: 15)
        
        button.addTarget(self, action: #selector(backHandle), for: .touchUpInside)
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 19)
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        label.text = "扫一扫"
        
        let x : CGFloat = (self.view.frame.width - 60) / 2
        let y : CGFloat = UIApplication.shared.statusBarFrame.size.height
        let w : CGFloat = 60
        let h : CGFloat = 44
        label.frame = CGRect.init(x: x, y: y, width: w, height: h)

        return label
    }()
}



//MARK: 通知回调，闭包回调，点击事件
extension MCScanViewController {
    @objc func backHandle() {
        self.destroy()
        
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    /// 开始
    public func scannerStart(){
        captureSession.startRunning()
        cameraView.beginAnimation()
    }
    
    /// 暂停
    public func scannerStop() {
        captureSession.stopRunning()
        cameraView.stopAnimation()
    }
    
    /// 销毁
    public func destroy() {
        cameraView.destroy()
    }
}


//MARK: UI的处理,通知的接收
extension MCScanViewController {
    
    func baseSetting() {
        self.view.backgroundColor = UIColor.black
    }
    
    
    func initUI() {
        self.view.addSubview(cameraView)
        
        view.addSubview(backButton)
        
        view.addSubview(titleLabel)
    }
    
    /// 设置捕获窗口
    func setCaptureWindow() {
        do{
            self.device = AVCaptureDevice.default(for: AVMediaType.video)
            
            if device == nil {
                return
            }
            
            self.input = try AVCaptureDeviceInput(device: device)
            
            self.output = AVCaptureMetadataOutput()
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            self.session = AVCaptureSession()
            if UIScreen.main.bounds.size.height<500 {
                self.session.sessionPreset = AVCaptureSession.Preset.vga640x480
            }else{
                self.session.sessionPreset = AVCaptureSession.Preset.high
            }
            
            self.session.addInput(self.input)
            self.session.addOutput(self.output)
            
            self.output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr,AVMetadataObject.ObjectType.ean13,AVMetadataObject.ObjectType.ean8,AVMetadataObject.ObjectType.code128]
            
            //设置可探测区域
            output.rectOfInterest = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
            
            self.preview = AVCaptureVideoPreviewLayer(session:self.session)
            self.preview.videoGravity = AVLayerVideoGravity.resizeAspectFill
            self.preview.frame = UIScreen.main.bounds
            self.view.layer.insertSublayer(self.preview, at:0)
            
            
            //开始捕获
            self.session.startRunning()
        }catch _ {
            //打印错误消息
            let alertController = UIAlertController(title: "提醒",
                                                    message: "请在iPhone的\"设置-隐私-相机\"选项中,允许本程序访问您的相机",
                                                    preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }

}



extension MCScanViewController : AVCaptureMetadataOutputObjectsDelegate {
    public func metadataOutput(_ output: AVCaptureMetadataOutput,
                               didOutput metadataObjects: [AVMetadataObject],
                               from connection: AVCaptureConnection) {
        var stringValue:String?
        if metadataObjects.count > 0 {
            let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            stringValue = metadataObject.stringValue
            if stringValue != nil{
                self.session.stopRunning()
            }
        }
        // 结束
        scannerStop()
        //输出结果
        let alertController = UIAlertController(title: "扫描结果",
                                                message: stringValue,preferredStyle: .alert)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.backHandle()
            
            self.delegate?.scanResult(str: stringValue!)
            
            alertController.dismiss(animated: true, completion: nil)
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
}
