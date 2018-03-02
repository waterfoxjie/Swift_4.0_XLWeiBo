//
//  XLComposeTypeView.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/3/2.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit

class XLComposeTypeView: UIView {

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = UIColor.yellow
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
