//
//  XLHomeNavTitleButton.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/1/29.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit
import SnapKit

class XLHomeNavTitleButton: UIButton {
    
    /// 重载 init 方法
    ///
    /// - Parameter title: title 判断 title 是否有值，有则显示/箭头，没有则显示“首页”
    init(title: String?) {
        super.init(frame: CGRect.zero)
        
        let btnTitle = title == nil ? "首页" : title! + " "
        let titleColor = UIColor.lightGray
        adjustsImageWhenHighlighted = false
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        setTitle(btnTitle, for: .normal)
        setTitleColor(titleColor, for: .normal)
        if title != nil {
            setImage(UIImage(named: "homeNavDownIcon"), for: .normal)
            setImage(UIImage(named: "homeNavUpIcon"), for: .selected)
            // 设置图片与文字位置
            guard let labelWidth = titleLabel?.intrinsicContentSize.width,
                let imageWidth = imageView?.intrinsicContentSize.width else {
                    return
            }
            titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth) ,0, imageWidth);
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -(labelWidth));
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
