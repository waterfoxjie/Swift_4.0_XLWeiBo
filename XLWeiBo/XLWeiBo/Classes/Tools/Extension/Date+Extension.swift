//
//  Date+Extension.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/1/25.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import Foundation

// MARK: - 日期相关
extension Date {
    
    /// 时间转字符串
    ///
    /// - Parameters:
    ///   - date: date  需要转的时间
    ///   - dateStyle: dateStyle  date 类型
    ///   - timeStyle: timeStyle  time 类型
    /// - Returns: 返回转好的字符串
    func dataWithString(dateStyle: DateFormatter.Style = .full,
                        timeStyle: DateFormatter.Style = .full) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}
