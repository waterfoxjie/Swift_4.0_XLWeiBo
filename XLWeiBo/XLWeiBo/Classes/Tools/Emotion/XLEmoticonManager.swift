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
