//
//  XLImageRefreshView.swift
//  图像优化处理
//
//  Created by waterfoxjie on 2018/3/1.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit

private let LogoBottomMargin: CGFloat = 40

class XLImageRefreshView: XLRefreshView {

    // 房子
    @IBOutlet weak var hourseView: UIImageView!
    // 地球
    @IBOutlet weak var diQiuView: UIImageView!
    // logo
    @IBOutlet weak var logoView: UIImageView!
    // 父视图高度
    override var parentHeight: CGFloat {
        didSet {
            if parentHeight < LogoBottomMargin {
                return
            }
            // 设置缩放比例
            var scale: CGFloat
            let viewH = self.bounds.height
            if parentHeight >= viewH {
                scale = 1
            } else {
                scale = 1 - (viewH - parentHeight) / (viewH - LogoBottomMargin)
            }
            logoView.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
    
    
    override func awakeFromNib() {
        // 地球旋转
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = -2 * CGFloat.pi
        anim.repeatCount = MAXFLOAT
        anim.duration = 3
        anim.isRemovedOnCompletion = false
        diQiuView.layer.add(anim, forKey: nil)
        // 设置 logo 的定位点
        // 1）、设置锚点
        logoView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        // 2）、设置 center
        let x = self.bounds.width * 0.5
        let y = self.bounds.height - LogoBottomMargin
        logoView.center = CGPoint(x: x, y: y)
    }

}
