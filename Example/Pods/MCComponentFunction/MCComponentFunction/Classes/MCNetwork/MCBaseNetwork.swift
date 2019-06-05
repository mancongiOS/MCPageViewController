//
//  MCBaseNetwork.swift
//  MCAPI
//
//  Created by MC on 2018/10/23.
//  Copyright © 2018年 MC. All rights reserved.
//

import Foundation
import Alamofire


public class MCBaseNetwork {
    
}

// MARK: post
extension MCBaseNetwork {
    // post网络请求
    public typealias MCBaseNetworkResult<T> = (Result<Any>) -> ()
    
    @discardableResult
    public static func POST(_ url: String!, _ params:[String:Any]? = [String:Any](),headers:HTTPHeaders?, _ queue:DispatchQueue? = nil,resultBack: @escaping MCBaseNetworkResult<Any>) -> DataRequest {
        
        // 配置网络请求时间
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 10
        
        
        return Alamofire.request(url, method: .post,
                                 parameters: params,
                                 encoding: JSONEncoding.default,
                                 headers: headers)
            .responseJSON(queue: queue) { (response) in
                
                let result = response.result
                resultBack(result)
        }
    }
    
    
    // get网络请求
    @discardableResult
    public static func GET(_ url: String!, _ params:[String:Any]? = [String:Any](),headers:HTTPHeaders?, _ queue:DispatchQueue? = nil,resultBack: @escaping MCBaseNetworkResult<Any>) -> DataRequest {
        
        // 配置网络请求时间
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 10
        
        
        return Alamofire.request(url, method: .get,
                                 parameters: params,
                                 encoding: JSONEncoding.default,
                                 headers: headers)
            .responseJSON(queue: queue) { (response) in
                
                let result = response.result
                resultBack(result)
        }
    }
}



// MARK: 异步加载图片
extension MCBaseNetwork {

    public typealias MCLoadImageResult = (UIImage?) -> ()

    /**
     * 异步加载图片
     * 注意在主线程刷新UI
     */
    public static func loadImage(_ urlStr:String,result:@escaping MCLoadImageResult) {

        //创建URL对象
        let url = URL.init(string: urlStr)
        //创建请求对象
        if url == nil {
            print("MCBaseNetwork 解析了一个错误的url: \(urlStr)")
            result(nil)
            return
        }

        let request = URLRequest(url: url!)

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            if error != nil{
                print(error.debugDescription)
                result(nil)
            }else{
                //将图片数据赋予UIImage
                let image = UIImage(data:data!)
                result(image!)
            }
        }) as URLSessionTask

        //使用resume方法启动任务
        dataTask.resume()
    }
}




