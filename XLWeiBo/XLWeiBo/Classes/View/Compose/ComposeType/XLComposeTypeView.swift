//
//  XLComposeTypeView.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/3/2.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit

class XLComposeTypeView: UIView {

    class func composeTypeView() -> XLComposeTypeView {
        let nib = UINib(nibName: "XLComposeTypeView", bundle: nil)
        let v = nib.instantiate(withOwner: nib, options: nil).last as! XLComposeTypeView
        v.frame = UIScreen.main.bounds
        return v
    }
    
    override func awakeFromNib() {
        addComposeTypeBtn()
    }
    
    func show() {
        // 获取当前控制器的根视图
        guard let vc = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        // 将视图添加到根视图的 view 中
        vc.view.addSubview(self)
    }
}

// 添加子控件
private extension XLComposeTypeView {
    func addComposeTypeBtn() {
        let btn = XLComposeTypeButton.composeTypeButton(imageName: "composeBtn01", title: "文字")
        btn.center = self.center
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        addSubview(btn)
    }
    
    @objc func btnClick() {
        print("点击我了")
    }
}
