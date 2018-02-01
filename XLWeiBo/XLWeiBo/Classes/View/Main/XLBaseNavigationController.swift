//
//  XLBaseNavigationController.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/1/17.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit

class XLBaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        customInit()
    }
    
    private func customInit() {
        navigationBar.titleTextAttributes =
            [NSAttributedStringKey.foregroundColor: UIColor.lightGray,
             NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize:17 * ScreenScale)]
    }

    // 重写 push 方法
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 隐藏二级界面之后的 TabBar
        // 根控制器不需要处理
        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }
}
