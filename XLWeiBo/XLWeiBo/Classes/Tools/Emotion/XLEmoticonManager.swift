//
//  XLEmoticonManager.swift
//  正则表达式
//
//  Created by waterfoxjie on 2018/3/9.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import Foundation
import ObjectMapper

class XLEmoticonManager {
    // 创建单例
    static let shared = XLEmoticonManager()
    // 表情包懒加载数组
    lazy var packageArray = [XLEmoticonPackage]()
    // 使调用时，只能用 shared
    private init() {
        loadPackages()
    }
}

extension XLEmoticonManager {
    
    /// 根据传进来 string 查找对用的 emotion
    ///
    /// - Parameter string: 查找的字符串
    /// - Returns: 返回对应的 XLEmoticonModel 对象
    func findEmotion(string: String) -> XLEmoticonModel? {
        // 遍历表情包
        for package in packageArray {
            // 在表情包中过滤 string（使用谓词）
            let results = package.emoticons.filter({ (model) -> Bool in
                return model.chs == string
            })
            if results.count >= 1 {
                return results.first
            }
        }
        return nil
    }
    
    // 将传入的字符串转换成 NSAttributedString
    func emotionString(string: String, textFont: UIFont) -> NSAttributedString {
        let attString = NSMutableAttributedString(string: string)
        // 1、使用正则表达式过滤所有的表情文字
        // 正则表达式中 []、() 都是保留字符，需要转义
        let pattern = "\\[.*?\\]"
        guard let reg = try? NSRegularExpression(pattern: pattern, options: []) else {
            return attString
        }
        // 匹配所有项
        let results = reg.matches(in: string, options: [], range: NSRange(location: 0, length: attString.length))
        // 遍历结果(需要倒序遍历替换，否则替换了前面的之后，会使得后面的范围失效)
        for rs in results.reversed() {
            let range = rs.range(at: 0)
            let rsStr = (string as NSString).substring(with: range)
            // 将拿到的字符串转成 NSAttributedString
            guard let emotionModel = XLEmoticonManager.shared.findEmotion(string: rsStr) else {
                continue
            }
            let imageStr = emotionModel.imageText(textFont: textFont)
            // 进行替换
            attString.replaceCharacters(in: range, with: imageStr)
        }
        // 统一设置字符串属性
        attString.addAttributes([NSAttributedStringKey.font: textFont], range: NSRange(location: 0, length: attString.length))
        return attString
    }
    
}

// 设置数据
private extension XLEmoticonManager {
    func loadPackages() {
        // 获取路径 / 创建 bundle / 获取 emoticons.plist 路径 / 建立模型数组
        guard let bundle = Bundle.main.emotionsBundle(),
            let plistPath = bundle.path(forResource: "emoticons.plist", ofType: nil),
            let array = NSArray(contentsOfFile: plistPath),
            let packages = Mapper<XLEmoticonPackage>().mapArray(JSONObject: array)
        else {
            return
        }
        // 设置表情包数组（使用 += 不会再次分配空间，直接追加数据）
        packageArray += packages
    }
}
