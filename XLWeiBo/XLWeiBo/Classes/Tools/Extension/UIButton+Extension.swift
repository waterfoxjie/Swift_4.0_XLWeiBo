//
//  UIButton+Extension.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/1/18.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit

extension UIButton {
    
    /// 自定义文字 + 图片 Button
    ///
    /// - Parameters:
    ///   - title: title
    ///   - fontSize: fontSize 默认值为 16
    ///   - normalTitleColor: normalTitleColor 字体颜色
    ///   - highlightedTitleColor: highlightedTitleColor  高亮字体颜色
    ///   - normalImageName: normalImageName  图片
    ///   - highlightedImageName: highlightedImageName  高亮图片
    ///   - target: target
    ///   - action: action
    convenience init(title: String,
                     fontSize: CGFloat = 16,
                     normalTitleColor: UIColor,
                     highlightedTitleColor: UIColor,
                     normalImageName: String,
                     highlightedImageName: String,
                     target: Any?,
                     action: Selector) {
        self.init()
        setTitle(title, for: .normal)
        setTitleColor(normalTitleColor, for: .normal)
        setTitleColor(highlightedTitleColor, for: .highlighted)
        titleLabel?.font = UIFont(name: "Helvetica Neue", size: fontSize)
        setImage(UIImage(named: normalImageName), for: .normal)
        setImage(UIImage(named: highlightedImageName), for: .highlighted)
        // 设置按钮与文字间距
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: -5)
        addTarget(target, action: action, for: .touchUpInside)
    }
    
    /// 自定义文字 Button
    ///
    /// - Parameters:
    ///   - title: title
    ///   - fontSize: fontSize 默认 16
    ///   - normalTitleColor: normalTitleColor  文字颜色
    ///   - highlightedTitleColor: highlightedTitleColor  高亮文字颜色
    ///   - target: target
    ///   - action: action
    convenience init(title: String,
                     fontSize: CGFloat = 16,
                     normalTitleColor: UIColor,
                     highlightedTitleColor: UIColor,
                     target: Any?,
                     action: Selector) {
        self.init()
        setTitle(title, for: .normal)
        setTitleColor(normalTitleColor, for: .normal)
        setTitleColor(highlightedTitleColor, for: .highlighted)
        titleLabel?.font = UIFont(name: "Helvetica Neue", size: fontSize)
        addTarget(target, action: action, for: .touchUpInside)
    }
    
    
    /// 自定义图片 Button
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
        self.init()
        setImage(UIImage(named: normalImageName), for: .normal)
        setImage(UIImage(named: highlightedImageName), for: .highlighted)
        addTarget(target, action: action, for: .touchUpInside)
    }
    
    
}
