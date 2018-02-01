//
//  String+Extension.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/1/25.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import Foundation
import UIKit

// MARK: - 路径相关
extension String {
    
    /// 拼接 Documnet 路径
    ///
    /// - Returns: 返回拼接好的路径
    func appendDocumnetDir() -> String {
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documnetPath = documentPaths.first! as NSString
        let filePath = documnetPath.appendingPathComponent(self)
        return filePath
    }
}

// MARK: - 日期相关
extension String {
    /// 字符串转时间
    ///
    /// - Parameters:
    ///   - dateStyle: dateStyle  date 类型
    ///   - timeStyle: timeStyle  time 类型
    /// - Returns: 返回转好的 Date
    func stringWithDate(dateStyle: DateFormatter.Style = .full,
                        timeStyle: DateFormatter.Style = .full) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle
        let date = dateFormatter.date(from: self)
        return date
    }
}

// MARK: - 间距相关
extension String {
    /// 调整行间距
    ///
    /// - Parameters:
    ///   - lineSpace: 行间距
    /// - Returns: 返回一个 NSAttributedString 类型
    func adjustLineSpacing(lineSpacing: CGFloat) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        let paragraphStyle = NSMutableParagraphStyle()
        // 调整行间距
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.alignment = .left
        let range = NSMakeRange(0, CFStringGetLength(self as CFString))
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: range)
        return attributedString
    }
}



