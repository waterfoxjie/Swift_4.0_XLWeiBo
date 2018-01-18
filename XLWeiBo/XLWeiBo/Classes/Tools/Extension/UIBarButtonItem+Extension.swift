//
//  UIBarButtonItem+Extension.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/1/17.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit
// convenience: 便利构造器

extension UIBarButtonItem {
    
    /// 自定义文字 BarButtonItem
    ///
    /// - Parameters:
    ///   - title: title
    ///   - fontSize: fontSize，默认值 16
    ///   - target: target
    ///   - action: action
    convenience init(title: String,
                     fontSize: CGFloat = 16,
                     target: Any?,
                     action: Selector) {
        let btn = UIButton(title: title,
                           fontSize: fontSize,
                           normalTitleColor: NormalTitleColor,
                           highlightedTitleColor: HighlightedTitleColor,
                           target: target,
                           action: action)
        // 使用 self.init 实例化
        self.init(customView: btn)
    }
    
    
    /// 自定义图片 BarButtonItem
    ///
    /// - Parameters:
    ///   - normalImageName: normalImageName  图片
    ///   - highlightedImageName: highlightedImageName  高亮图片
    ///   - target: target
    ///   - action: action
    convenience init(normalImageName: String,
                     highlightedImageName: String,
                     target: Any?,
                     action: Selector) {
        let btn = UIButton(normalImageName: normalImageName,
                           highlightedImageName: highlightedImageName,
                           target: target,
                           action: action)
        // 使用 self.init 实例化
        self.init(customView: btn)
    }
    
    
    /// 自定义文字 + 图片 BarButtonItem
    ///
    /// - Parameters:
    ///   - title: title
    ///   - fontSize: fontSize 默认 16
    ///   - normalImageName: normalImageName  图片
    ///   - highlightedImageName: highlightedImageName  高亮图片
    ///   - target: target
    ///   - action: action
    convenience init(title: String,
                     fontSize: CGFloat = 16,
                     normalImageName: String,
                     highlightedImageName: String,
                     target: Any?,
                     action: Selector) {
        let btn = UIButton(title: title,
                           fontSize: fontSize,
                           normalTitleColor: NormalTitleColor,
                           highlightedTitleColor: HighlightedTitleColor,
                           normalImageName: normalImageName,
                           highlightedImageName: highlightedImageName,
                           target: target,
                           action: action)
        self.init(customView: btn)
    }
    
}
