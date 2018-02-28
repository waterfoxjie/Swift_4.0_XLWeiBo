//
//  XLRefreshView.swift
//  图像优化处理
//
//  Created by waterfoxjie on 2018/2/27.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit

class XLRefreshView: UIView {

    // 提示图片
    @IBOutlet weak var tipImageView: UIImageView!
    // 提示文字
    @IBOutlet weak var tipLabel: UILabel!
    // 菊花
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    // 从 xib 中加载控件
    class func refreshView() -> XLRefreshView {
        let nib = UINib(nibName: "XLRefreshView", bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil).last as! XLRefreshView
    }
}

