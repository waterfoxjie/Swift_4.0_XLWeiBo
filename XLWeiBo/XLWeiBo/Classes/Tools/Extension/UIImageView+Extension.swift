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
                     placeholderImage: UIImage?,
                     isAvatar: Bool = false) {
        // 判断是否有值，没有则设置为占位图片
        guard let urlString = urlString,
            let url = URL(string: urlString) else {
                // 判断是否是
                isAvatar ? (image = placeholderImage?.avatarImage(size: self.bounds.size)) : (image = placeholderImage)
                return
        }
        // 添加 [weak self] 是为了防止循环引用
        sd_setImage(with: url) { [weak self](image, _, _, _) in
            if image == nil {
                isAvatar ? (self?.image = placeholderImage?.avatarImage(size: self?.bounds.size)) : (self?.image = placeholderImage)
            } else {
                isAvatar ? (self?.image = image?.avatarImage(size: self?.bounds.size)) : (self?.image = image)
            }
        }
    }
}
