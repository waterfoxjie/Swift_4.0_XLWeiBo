//
//  XLEmoticonModel.swift
//  正则表达式
//
//  Created by waterfoxjie on 2018/3/12.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit
import ObjectMapper

// 表情模型
class XLEmoticonModel: Mappable {
    
    // 表情类型 - 0 图片表情 / 1 emoji
    var type: String?
    // 表情字符串，发送给新浪微博服务器
    var chs: String?
    // 表情图片名称，用于图文混排
    var png: String?
    // emoji 的十六进制码
    var code: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        type <- map["type"]
        chs  <- map["chs"]
        png  <- map["png"]
        code <- map["code"]
    }
}
