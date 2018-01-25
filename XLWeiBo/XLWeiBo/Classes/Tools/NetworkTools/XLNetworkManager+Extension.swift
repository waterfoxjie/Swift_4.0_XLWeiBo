//
//  XLNetworkManager+Extension.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/1/19.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import Foundation

// MARK: - 首页微博的网络请求
extension XLNetworkManager {
    
    /// 首页获取微博接口
    ///
    /// - Parameters:
    ///   - since_id: since_id  返回ID比since_id大的微博（即下拉刷新），默认为0
    ///   - max_id:   max_id  返回ID小于或等于max_id的微博（即上拉刷新），默认为0
    ///   - completion: completion
    func homeTimelineRequest(since_id: Int64 = 0,
                             max_id: Int64 = 0,
                             completion: 
        @escaping (_ list: [[String: AnyObject]]?, _ isSuccess: Bool) -> Void) {
       
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let params = ["since_id": "\(since_id)",
                      "max_id": "\(max_id)"]
    
        tokenRequest(urlString: urlString, parameters: params as [String : AnyObject]) { (json, isSuccess) in
            let result = (json as AnyObject)["statuses"] as? [[String: AnyObject]]
            completion(result, isSuccess)
        }
    }
}

// MARK: - Access Token 的网络请求
extension XLNetworkManager {
    func accessTokenRequest(code: String) {
        let urlString = "https://api.weibo.com/oauth2/access_token"
        /* 参数说明
           client_id      申请应用时分配的 AppKey
           client_secret  申请应用时分配的 AppSecret
           grant_type     请求的类型，写 “authorization_code”
           code           调用 authorize 获得的 code 值
           redirect_uri   注册应用时填写的回调地址
         */
        let params = ["client_id": WeiBoAppKey,
                      "client_secret": WeiBoAppSecret,
                      "grant_type": "authorization_code",
                      "code": code as String,
                      "redirect_uri": WeiBoRedirectUri]
        request(method: .POST, urlString: urlString, parameters: params as [String : AnyObject]) { (json, isSuccess) in
            // 字典转模型
            self.userAccout.yy_modelSet(with: json as? [String : AnyObject] ?? [:])
        }
    }
}
