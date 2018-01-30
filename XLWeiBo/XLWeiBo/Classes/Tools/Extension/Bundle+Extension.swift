//
//  Bundle+Extension.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/1/17.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import Foundation

extension Bundle {
    // 拿到 BundleName 的值，并设置成一个计算型属性进行返回
    var nameSpace: String {
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
    // 拿到 CFBundleShortVersionString 的值，版本号
    var versionSpace: String {
        return infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
}
