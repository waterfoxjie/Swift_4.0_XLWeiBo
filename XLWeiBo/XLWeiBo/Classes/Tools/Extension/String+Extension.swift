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
    func adjustLineSpacing(lineSpacing: CGFloat,
                           viewWidth: CGFloat,
                           textFont: UIFont) -> NSAttributedString {
        let sizeRect = getStringRect(textFont: textFont, viewWidth: viewWidth)
        print("sizeRect = \(sizeRect.width)")
        let attributedString = NSMutableAttributedString(string: self)
        let paragraphStyle = NSMutableParagraphStyle()
        var spacing = lineSpacing
        // 根据是否大于 View 宽度设置行距（解决只有一行时也有间距问题）
        if sizeRect.width < viewWidth {
            spacing = 0
        }
        // 判断文字中是否有换行符（解决有换行符，宽度又不大于 View 宽度，没有行距问题）
        if contains("\n") {
            spacing = lineSpacing
        }
        // 调整行间距
        paragraphStyle.lineSpacing = spacing
        paragraphStyle.alignment = .left
        let range = NSMakeRange(0, CFStringGetLength(self as CFString))
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: range)
        return attributedString
    }
    
    
    /// 获取当前字符串的大小
    ///
    /// - Parameters:
    ///   - text: 字符串
    ///   - font: 文字大小
    /// - Returns: 返回对应大小
    func getStringRect(textFont: UIFont,
                       viewWidth: CGFloat) -> CGRect {
        let temptext = NSString(string: self)
        let size = CGSize(width: viewWidth, height: 0)
        let options = NSStringDrawingOptions.usesFontLeading
        let boundRect = temptext.boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: textFont], context: nil)
        return boundRect
    }
}





