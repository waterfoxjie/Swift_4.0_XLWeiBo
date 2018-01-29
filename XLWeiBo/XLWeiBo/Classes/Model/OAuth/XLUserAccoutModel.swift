//
//  XLUserAccoutModel.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/1/25.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit
import ObjectMapper

private let accoutFileName = "UserAccout.json"
private let accessTokenStr = "accessToken"
private let expiresDataStr = "expiresData"
private let uidStr = "uid"
private let screenNameStr = "screenName"
private let avatarLargeImageStr = "avatarLargeImage"


class XLUserAccoutModel: Mappable {
    // MARK: - 设置属性
    // 用户授权的唯一票据，用于调用微博的开放接口，同时也是第三方应用验证微博用户登录的唯一票据
    var accessToken: String?
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
    // 用户昵称
    var screenName: String?
    // 用户头像地址（大图），180×180像素
    var avatarLargeImage: String?
    
    init() {
        // 拿到磁盘存储的数据
        let filePath = accoutFileName.appendDocumnetDir()
        guard let data = NSData(contentsOfFile: filePath),
            // 反序列化
            let dict = try? JSONSerialization.jsonObject(with: data as Data, options: []) as! NSDictionary
            else {
            return
        }
        // 设置模型值
        expiresData = (dict[expiresDataStr] as! String).stringWithDate()
        accessToken = dict[accessTokenStr] as? String
        uid = dict[uidStr] as? String
        screenName = dict[screenNameStr] as? String
        avatarLargeImage = dict[avatarLargeImageStr] as? String
        // 判断是否过期
        if expiresData?.compare(Date()) != .orderedDescending {
            // 清空数据
            accessToken = nil
            uid = nil
            // 删除磁盘文件
            _ = try? FileManager.default.removeItem(atPath: filePath)
        }
        
    }
    
    required init?(map: Map) {
    }
    
    // 字典转模型
    func mapping(map: Map) {
        accessToken      <- map["access_token"]
        expiresIn        <- map["expires_in"]
        uid              <- map["uid"]
        screenName       <- map["screen_name"]
        avatarLargeImage <- map["avatar_large"]
    }
    
    // 将数据保存在 Documnet 目录下
    func saveInfo() {
        // 对时间进行处理
        let dateString = expiresData?.dateWithString()
        // 创建一个字典
        let dict: [String: Any] = [accessTokenStr: accessToken ?? "",
                                   expiresDataStr: dateString ?? "",
                                   uidStr: uid ?? "",
                                   screenNameStr: screenName ?? "",
                                   avatarLargeImageStr: avatarLargeImage ?? ""]
        // 字典反序列化
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: [])
        else {
            return
        }
        let filePath = accoutFileName.appendDocumnetDir()
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
