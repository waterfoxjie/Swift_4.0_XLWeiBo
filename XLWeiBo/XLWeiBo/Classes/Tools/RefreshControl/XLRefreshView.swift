//
//  XLRefreshView.swift
//  图像优化处理
//
//  Created by waterfoxjie on 2018/2/27.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit

private let TipImageAnimateTimer = 0.25

class XLRefreshView: UIView {

    // 提示图片
    @IBOutlet weak var tipImageView: UIImageView?
    // 提示文字
    @IBOutlet weak var tipLabel: UILabel?
    // 菊花
    @IBOutlet weak var indicator: UIActivityIndicatorView?
    // 刷新状态
    /*
     iOS 系统中 UIView 封装的旋转动画
     - 默认顺时针方向旋转
     - 就近原则
     - 要想实现同方向旋转，需要调整一个非常小的数字（使其近）
     */
    var refreshState: XLRefreshState = .Normal {
        didSet {
            switch refreshState {
            case .Normal:
                tipLabel?.text = "下拉刷新更多数据"
                // 显示提示图片，隐藏菊花
                tipImageView?.isHidden = false
                indicator?.stopAnimating()
                // 恢复提示图片样式
                UIView.animate(withDuration: TipImageAnimateTimer, animations: {
                    self.tipImageView?.transform = CGAffineTransform.identity
                })
            case .Pulling:
                tipLabel?.text = "放手就刷新数据"
                // 旋转提示图片
                UIView.animate(withDuration: TipImageAnimateTimer, animations: {
                    self.tipImageView?.transform = CGAffineTransform(rotationAngle: CGFloat(.pi - 0.001))
                })
            case .WillRefresh:
                tipLabel?.text = "正在刷新中..."
                // 隐藏提示图片，显示菊花
                tipImageView?.isHidden = true
                indicator?.startAnimating()
            }
        }
    }
    
    // 从 xib 中加载控件
    class func refreshView() -> XLRefreshView {
        let nib = UINib(nibName: "XLImageRefreshView", bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil).last as! XLRefreshView
    }
}

