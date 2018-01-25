//
//  XLUserAccoutModel.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/1/25.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit
import ObjectMapper

class XLUserAccoutModel: Mappable {
    // MARK: - 设置属性
    // 用户授权的唯一票据，用于调用微博的开放接口，同时也是第三方应用验证微博用户登录的唯一票据
    var accessToken: String? //= "2.004YlqECaCmxOD8609ab5602EIicWB"
    // access_token 的生命周期
    var expiresIn: TimeInterval = 0 {
        didSet {
            expiresData = Date(timeIntervalSinceNow: expiresIn)
        }
    }
    // 过期时间（使用者：3天，开发者：5年）
    var expiresData: Date?
    // 授权用户的UID
    var uid: String?
    
    init() {
        
    }
    
    required init?(map: Map) {
    }
    
    // 字典转模型
    func mapping(map: Map) {
        accessToken <- map["access_token"]
        expiresIn   <- map["expires_in"]
        uid         <- map["uid"]
    }
    
    // 将数据保存在 Documnet 目录下
    func saveInfo() {
        // 对时间进行处理
        let dateString = expiresData?.dataWithString()
        // 创建一个字典
        let dict: [String: Any] = ["accessToken": accessToken ?? "",
                                   "expiresData": dateString ?? "",
                                   "uid": uid ?? ""]
        // 存储路径
        let fileName = "UserAccout.json"
        // 字典反序列化
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: [])
        else {
            return
        }
        let filePath = fileName.appendDocumnetDir()
        // 存入磁盘（保存在 Document 目录下）
        (data as NSData).write(toFile: filePath, atomically: true)
        print("用户信息保存成功：\(filePath)")
    }
}

/*
 "access_token" = "2.004YlqECaCmxOD8609ab5602EIicWB";
 "expires_in" = 157679999;
 isRealName = true;
 "remind_in" = 157679999;
 uid = 1903946863;
 */
