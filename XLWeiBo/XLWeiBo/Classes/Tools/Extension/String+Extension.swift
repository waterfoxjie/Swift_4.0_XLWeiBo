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
    ///   - isMultiLine: 是否多行，默认 true
    /// - Returns: 返回对应大小
    func getStringRect(textFont: UIFont,
                       viewWidth: CGFloat) -> CGSize {
        let temptext = NSString(string: self)
        let size = CGSize(width: viewWidth, height: CGFloat(MAXFLOAT))
        var options = NSStringDrawingOptions.usesLineFragmentOrigin
        let boundRect = temptext.boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: textFont], context: nil)
        return boundRect.size
    }
}

// MARK: - 正则表达式
extension String {
    // 获取首页微博来源
    func obtainSource() -> (href: String, text: String)? {
        // pattern ：匹配方法
        let pattern = "<a href=\"(.*?)\".*?>(.*?)</a>"
        // 如果 pattern 失败会抛出异常
        guard let regu = try? NSRegularExpression(pattern: pattern, options: []),
            // 进行查找（两种：只找第一个匹配项，查找多个匹配项）
            // result 中只有两个重要的方法
            // result.numberOfRanges -> 查找到的范围数量
            // result.range(at: Int) -> 指定“索引”位置的范围
            // 索引 ：0 -> 和匹配方案完全一致的字符；1 -> 第一个()中的内容...
            let result = regu.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.count)) else {
                return nil
        }
        let href = (self as NSString).substring(with: result.range(at: 1))
        let text = (self as NSString).substring(with: result.range(at: 2))
        return (href, text)
    }
}




