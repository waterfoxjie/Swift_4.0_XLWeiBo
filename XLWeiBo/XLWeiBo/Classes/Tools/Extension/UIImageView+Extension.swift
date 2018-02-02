//
//  UIImageView+Extension.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/2/2.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import SDWebImage

extension UIImageView {
    
    /// 封装 SDWebImage 方法
    ///
    /// - Parameters:
    ///   - urlString:        urlString
    ///   - placeholderImage: placeholderImage  占位图像
    ///   - isAvatar:         isAvatar  是否要设置圆角，默认 false
    func xl_setImage(urlString: String?,
                     placeholderImage: UIImage?) {
        // 设置占位图片，修复图片加载时空白 bug
        image = placeholderImage
        // 判断是否有值
        guard let urlString = urlString,
              let url = URL(string: urlString) else {
                return
        }
        sd_setImage(with: url, placeholderImage: placeholderImage)
    }
}
