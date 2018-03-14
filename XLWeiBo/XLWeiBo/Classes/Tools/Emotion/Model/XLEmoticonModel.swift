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
    // ‘图片’表情对应的图像
    private var image: UIImage?
    // 目录（用于获取图片使用）
    var directory: String? {
        didSet {
            guard let bundle = Bundle.main.emotionsBundle(),
                let directory = directory,
                let png = png
            else {
                return
            }
            // 拿到数据之后设置对应的图片
            image = UIImage(named: "\(directory)/\(png)", in: bundle, compatibleWith: nil)
        }
    }
    
    func imageText(textFont: UIFont) -> NSAttributedString {
        // 判断是否有值
        guard let image = image else {
            return NSAttributedString(string: "")
        }
        let attachment = NSTextAttachment()
        attachment.image = image
        // 设置高度
        let height = textFont.lineHeight
        attachment.bounds = CGRect(x: 0, y: -3, width: height, height: height)
        // 返回创建的属性文本
        return NSAttributedString(attachment: attachment)
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        type <- map["type"]
        chs  <- map["chs"]
        png  <- map["png"]
        code <- map["code"]
    }
}
