//
//  UIImage+Extension.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/1/31.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit

extension UIImage {
    
    /// 设置拉伸、不透明、圆型图片
    ///
    /// - Parameters:
    ///   - size:      要拉伸的大小
    ///   - backColor: 背景颜色，默认 white
    ///   - lineColor: 线条颜色，默认 lightGray
    /// - Returns: 返回设置好的图片
    func avatarImage(size: CGSize,
                     backColor: UIColor = UIColor.white,
                     lineColor: UIColor = UIColor.lightGray) -> UIImage? {
        let rect = CGRect(origin: CGPoint(), size: size)
        // 获取图形上下文
        /*
         size：上下文大小
         opaque：是否是不透明的，false：否，true：是
         scale：默认生成 1.0 分辨率的图像，可以写 0.0，会根据当前屏幕的分辨率进行设置
         */
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0.0)
        // 先进行背景颜色填充，使得裁切之后，被裁部分颜色与背景颜色一致
        backColor.setFill()
        UIRectFill(rect)
        // 绘制一个圆形路径
        let path = UIBezierPath(ovalIn: rect)
        // 进行裁切，裁切之后后续的图形都会在圆形中进行绘制
        path.addClip()
        // 绘制图像
        draw(in: rect)
        // 绘制图形
        lineColor.setStroke()
        path.lineWidth = 2
        path.stroke()
        // 取得结果
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        // 关闭图形上下文
        UIGraphicsEndImageContext()
        // 返回结果
        return resultImage
    }
}
