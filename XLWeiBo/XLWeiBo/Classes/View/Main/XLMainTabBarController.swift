//
//  XLMainTabBarController.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/1/17.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit

class XLMainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildViewController()
    }
}

// extension 类似于 OC 的分类，Swift 中也可以用来切分代码块
// 可以把相近功能的函数，放在一个 extension 中
// MARK: - 设置界面
extension XLMainTabBarController {
    // 设置子控件
    private func setupChildViewController() {
        let infoArray = [
            ["className": "XLHomeViewController", "title": "首页", "imageName": "home"],
            ["className": "XLMessageViewController", "title": "消息", "imageName": "message_center"],
            ["className": "XLDiscoverViewController", "title": "发现", "imageName": "discover"],
            ["className": "XLProfileViewController", "title": "我的", "imageName": "profile"]
        ]
        var controllerArray = [UIViewController]()
        for dict in infoArray {
            let vc = setupController(dict: dict)
            controllerArray.append(vc)
        }
        viewControllers = controllerArray
        tabBar.tintColor = UIColor.orange
    }
    
    // 使用一个字典来创建子控制器
    // dict 信息字典（包好 className, title, imageName）
    private func setupController(dict: [String: String]) -> UIViewController {
        // 获取字典内容
        guard let className = dict["className"],
              let title = dict["title"],
              let imageName = dict["imageName"] else {
            return UIViewController()
        }
        // 创建视图控制器
        // 1、将 className 转换成控制器
        let cls = NSClassFromString(Bundle.main.nameSpace + "." + className) as? UIViewController.Type
        // 2、创建控制器
        let vc = cls?.init()
        vc?.title = title
        vc?.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        let nav = UINavigationController(rootViewController: vc!)
        return nav
    }
}














