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
    // 中部按钮
    private lazy var composeButton: UIButton = UIButton()
    // 定时器
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildViewController()
        setupComposeButton()
        setupTimer()
        
        // 设置代理
        delegate = self
    }
    
    // 销毁定时器
    deinit {
        timer?.invalidate()
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
        // 拿到 Json 文件中的数据
        // path 路径  data 转换成 NSData  infoArray data 反序列化
        guard let path = Bundle.main.path(forResource: "mainVisitorData.json", ofType: nil),
              let data = NSData(contentsOfFile: path),
              let infoArray = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [[String: Any]]
            else {
            return
        }
        var controllerArray = [UIViewController]()
        for dict in infoArray! {
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
        let buttonW = tabBar.bounds.size.width / CGFloat(childViewControllers.count)
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
              let visitorInfoDict = dict["visitorInfo"] as? [String: Any]
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
        vc?.visitorInfoDict = visitorInfoDict
        let nav = XLBaseNavigationController(rootViewController: vc!)
        return nav
    }
    
    // TODO 待写
    // + 按钮点击方法
    @objc private func clickComposeButton() {
        print("点击")
    }
}


// MARK: - 设置定时器相关内容
extension XLMainTabBarController {
    // 定义定时器
    private func setupTimer() {
        // 用户未登录则不需要创建定时器
        if !XLNetworkManager.shareManager.userLogon {
            return
        }
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        let count = 5
        // 设置首页 TabBarItem 的 badgeValue 显示红点
        self.tabBar.items?.first?.badgeValue = "\(count)"
        // 设置 App 的 BadgeNumber
        UIApplication.shared.applicationIconBadgeNumber = count
    }
}

// MARK: - 实现 UITabBarDelegate 代理方法
extension XLMainTabBarController: UITabBarControllerDelegate {
    
    /// 将要选择 TabBarItem
    ///
    /// - Parameters:
    ///   - tabBarController: tabBarController
    ///   - viewController: 目标控制器
    /// - Returns: 是否切换到目标控制器
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        // 获取控制器在数组中的索引
        let index = childViewControllers.index(of: viewController)
        // 判断是否是重复点击首页
        if selectedIndex == 0 && index == selectedIndex {
            // 获取当前控制器
            let nav = childViewControllers.first as! XLBaseNavigationController
            let vc = nav.childViewControllers.first as! XLHomeViewController
            // 让表格滚动到顶部
            vc.tableView?.setContentOffset(CGPoint(x: 0, y: -64), animated: true)
            // 使用 asyncAfter 是为了解决加上刷新数据之后，表格无法滚动到顶部的问题
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
                // 刷新数据
                vc.loadData()
            })
        }
        
        // 判断点击到的是否是中间的按钮，是则不跳转，不是则跳转
        return !viewController.isMember(of: UIViewController.self)
    }
}












