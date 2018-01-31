//
//  UIColor+Extension.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/1/31.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit

extension UIColor {
    /**
     获取颜色，通过16进制色值字符串，e.g. #ff0000， ff0000
     - parameter hexString  :
     - parameter alpha      : 透明度，默认为1，不透明
     - returns: RGB
     */
    
    /// 根据传进来的字符串返回 UIColor
    ///
    /// - Parameters:
    ///   - hexString: 16进制字符串
    ///   - alpha:     透明度，默认 1
    /// - Returns: UIColor
    static func colorwithHexString(hexString: String,
                                   alpha: CGFloat = 1) -> UIColor {
        // 去除空格等
        var cString: String = hexString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        // 去除 #
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        // 剩余的字符串必须为 6 位
        if ((cString as NSString).length != 6) {
            return UIColor.gray
        }
        // 红、绿、蓝的色值
        let rString = (cString as NSString).substring(with: NSRange(location: 0, length: 2))
        let gString = (cString as NSString).substring(with: NSRange(location: 2, length: 2))
        let bString = (cString as NSString).substring(with: NSRange(location: 4, length: 2))
        // 字符串转换
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
}
