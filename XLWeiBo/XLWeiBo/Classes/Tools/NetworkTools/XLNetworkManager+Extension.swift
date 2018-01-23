//
//  XLNetworkManager+Extension.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/1/19.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import Foundation

// 封装微博的网络请求
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
