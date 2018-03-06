//
//  XLComposeTypeButton.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/3/5.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit

class XLComposeTypeButton: UIControl {

    // 图片
    @IBOutlet weak var imageView: UIImageView!
    // 文字
    @IBOutlet weak var tipLabel: UILabel!
    
    class func composeTypeButton(imageName: String, title: String) -> XLComposeTypeButton {
        let nib = UINib(nibName: "XLComposeTypeButton", bundle: nil)
        let btn = nib.instantiate(withOwner: nil, options: nil).last as! XLComposeTypeButton
        btn.imageView.image = UIImage(named: imageName)
        btn.tipLabel.text = title
        return btn
    }
    
}
