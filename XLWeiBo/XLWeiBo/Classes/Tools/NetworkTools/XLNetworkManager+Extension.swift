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
    
    // 首页获取微博接口
    func homeTimelineRequest(completion: @escaping (_ list: [[String: AnyObject]]?, _ isSuccess: Bool) -> ()) {
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        
        tokenRequest(urlString: urlString, parameters: nil) { (json, isSuccess) in
            let result = (json as AnyObject)["statuses"] as? [[String: AnyObject]]
            completion(result, isSuccess)
        }
    }
}
