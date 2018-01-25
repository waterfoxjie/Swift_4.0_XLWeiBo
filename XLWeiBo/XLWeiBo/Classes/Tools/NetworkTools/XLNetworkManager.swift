//
//  XLNetworkManager.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/1/19.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit
import AFNetworking

// 网络类型
enum XLHTTPMethod {
    case GET
    case POST
}

// 网络管理工具
class XLNetworkManager: AFHTTPSessionManager {
    // 创建 token(访问令牌)
    var accessToken: String? //= "2.004YlqECaCmxOD3cee65c871GBdoDB"
    // 创建登录标记（计算型属性）
    var userLogon: Bool {
        return accessToken != nil
    }
    
    // 创建单例
    static let shareManager = XLNetworkManager()
    
    /// 封装 token 请求
    ///
    /// - Parameters:
    ///   - method: method
    ///   - urlString: urlString
    ///   - parameters: parameters  可为nil
    ///   - completion: completion
    func tokenRequest(method: XLHTTPMethod = .GET,
                      urlString: String,
                      parameters: [String: AnyObject]?,
                      completion: @escaping (_ json: Any?, _ isSuccess: Bool) -> Void) {
        // 判断 token 是否有值
        guard let token = accessToken else {
            print("没有 token，需要进行登录操作")
            completion(nil, false)
            return
        }
        // 判断字典是否有值
        var parameters = parameters
        if parameters == nil {
            // 没有则创建一个
            parameters = [String: AnyObject]()
        }
        parameters!["access_token"] = token as AnyObject
        request(method: method, urlString: urlString, parameters: parameters!, completion: completion)
    }
    
    /// 封装 AFN 中的 GET、POST 方法
    ///
    /// - Parameters:
    ///   - method: method  GET / POST
    ///   - urlString: urlString
    ///   - parameters: parameters  参数字典
    ///   - completion: completion  回调闭包
    func request(method: XLHTTPMethod = .GET,
                 urlString: String,
                 parameters: [String: AnyObject],
                 completion: @escaping (_ json: Any?, _ isSuccess: Bool) -> Void) {
        // 定义两个回调闭包
        let success = { (task: URLSessionDataTask, json: Any?) -> Void in
            completion(json, true)
        }
        let failure = { (task: URLSessionDataTask?, error: Any) -> Void in
            print(error)
            // 对返回值 403 的情况做处理
            if (task?.response as! HTTPURLResponse).statusCode == 403 {
                print("token过期，请重新登录")
            }
            completion(task, false)
        }
        if method == .GET {
            get(urlString, parameters: parameters, progress: nil, success: success, failure: failure)
        } else {
            post(urlString, parameters: parameters, progress: nil, success: success, failure: failure)
        }
    }
}
