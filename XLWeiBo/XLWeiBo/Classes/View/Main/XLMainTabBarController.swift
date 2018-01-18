//
//  XLMainTabBarController.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/1/17.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit

class XLMainTabBarController: UITabBarController {

    // 私有控件
    private lazy var composeButton: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildViewController()
        setupComposeButton()
    }
    
    // 设置支持的方向之后，当前的控制器及子控制器否会遵守这个方向
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

// extension 类似于 OC 的分类，Swift 中也可以用来切分代码块
// 可以把相近功能的函数，放在一个 extension 中
// MARK: - 设置界面
extension XLMainTabBarController {
    // 设置子控件
    private func setupChildViewController() {
        let homeModel =
            XLVisitorInfoModel(imageName: "visitordiscover_feed_image_smallicon",
                               message: "关注一些人，回这里看看有什么惊喜",
                               isHome: true)
        let messageModel =
            XLVisitorInfoModel(imageName: "visitordiscover_image_message",
                               message: "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知",
                               isHome: false)
        let discoverModel =
            XLVisitorInfoModel(imageName: "visitordiscover_image_message",
                               message: "登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过",
                               isHome: false)
        let profileModel =
            XLVisitorInfoModel(imageName: "visitordiscover_image_profile",
                               message: "登录后，你的微博、相册、个人资料会显示在这里，展示给别人",
                               isHome: false)
        let infoArray: [[String: Any]] = [
            ["className": "XLHomeViewController", "title": "首页", "imageName": "home", "visitorInfo": homeModel],
            ["className": "XLMessageViewController", "title": "消息", "imageName": "message_center", "visitorInfo": messageModel],
            [:],
            ["className": "XLDiscoverViewController", "title": "发现", "imageName": "discover", "visitorInfo": discoverModel],
            ["className": "XLProfileViewController", "title": "我的", "imageName": "profile", "visitorInfo": profileModel]
        ]
        var controllerArray = [UIViewController]()
        for dict in infoArray {
            let vc = setupController(dict: dict)
            controllerArray.append(vc)
        }
        viewControllers = controllerArray
        tabBar.tintColor = UIColor.orange
    }
    
    // 设置中间的按钮
    private func setupComposeButton() {
        composeButton.setImage(UIImage(named: "tabbar_compose_icon_add"), for: .normal)
        composeButton.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), for: .highlighted)
        tabBar.addSubview(composeButton)
        composeButton.setBackgroundImage(UIImage(named: "tabbar_compose_button"), for: .normal)
        composeButton.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), for: .highlighted)
        // 计算按钮宽度
        // -1 是为了将内缩进的宽度减少，让按钮的宽度变大吗盖住容错点
        let buttonW = tabBar.bounds.size.width / CGFloat(childViewControllers.count) - 1
        // insetBy 整数向内缩进，负数向外扩展
        composeButton.frame = tabBar.bounds.insetBy(dx: 2 * buttonW, dy: 0)
        // 添加方法
        composeButton.addTarget(self, action: #selector(self.clickComposeButton), for: .touchUpInside)
    }
    
    // 使用一个字典来创建子控制器
    // dict 信息字典（包好 className, title, imageName）
    private func setupController(dict: [String: Any]) -> UIViewController {
        // 获取字典内容
        guard let className = dict["className"] as? String,
              let title = dict["title"] as? String,
              let imageName = dict["imageName"] as? String,
              let visitorInfoModel = dict["visitorInfo"] as? XLVisitorInfoModel
            else {
            return UIViewController()
        }
        // 创建视图控制器
        // 1、将 className 转换成控制器
        let cls = NSClassFromString(Bundle.main.nameSpace + "." + className) as? XLBaseViewController.Type
        // 2、创建控制器
        let vc = cls?.init()
        // 3、设置控制器 TabBar 以及 title
        vc?.title = title
        vc?.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        // 4、设置控制器 visitorInfo
        vc?.visitorInfoModel = visitorInfoModel
        let nav = XLBaseNavigationController(rootViewController: vc!)
        return nav
    }
    
    // TODO 待写
    // + 按钮点击方法
    @objc private func clickComposeButton() {
        print("点击")
    }
}














