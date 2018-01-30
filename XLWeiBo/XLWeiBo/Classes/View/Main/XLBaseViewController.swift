//
//  XLBaseViewController.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/1/17.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit

class XLBaseViewController: UIViewController {
    
    var tableView: UITableView?
    var resfreshC: UIRefreshControl?
    var visitorInfoDict: [String: Any]?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // 注册登录成功通知
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: NSNotification.Name(rawValue: WeiBoLoginSuccessNotification), object: nil)
    }
    
    // 需要被重写的方法不能写在 extension 中
    // 子类重写此方法进行基础设置（用户登录之后才调用的）
    func baseSetup() {
    }
    
    // 加载数据
    @objc func loadData() {
        // 默认收起
        self.resfreshC?.endRefreshing()
    }
    
    deinit {
        // 销毁通知
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - 设置界面
extension XLBaseViewController {
    
    // 根据用户是否登录显示不同的界面
    private func setupUI() {
        view.backgroundColor = UIColor.white
        XLNetworkManager.shareManager.userLogon ? setupTableView() : setupVisitorView()
    }
    
    // 设置 tableView
    private func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView?.delegate = self;
        tableView?.dataSource = self
        view.addSubview(tableView!)
        
        // 设置刷新控件
        resfreshC = UIRefreshControl()
        tableView?.addSubview(resfreshC!)
        resfreshC?.addTarget(self, action: #selector(loadData), for: .valueChanged)
        baseSetup()
    }
    
    // 设置访客视图
    private func setupVisitorView() {
        let visitorView = XLVisitorView(frame: view.bounds)
        view.addSubview(visitorView)
        // 设置背景颜色
        visitorView.backgroundColor = UIColor(red: 237.0 / 255.0, green: 237.0 / 255.0, blue: 237.0 / 255.0, alpha: 1.0)
        // 设置数据
        visitorView.setupChildrenViewInfo(dict: visitorInfoDict!)
        // 设置按钮事件
        visitorView.loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        visitorView.registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        // 设置导航条按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(register))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(login))
        
    }
}

// MARK: - 注册、登录按钮方法
extension XLBaseViewController {
    // 登录
    @objc private func login() {
        // 发送通知
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: WeiBoLoginNotification), object: nil)
    }
    
    // 注册
    @objc private func register() {
        print("注册")
    }
}

// MARK: - TableView 代理、数据源方法
extension XLBaseViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - 通知方法
extension XLBaseViewController {
    @objc private func updateUI() {
        // 在访问 view 的 getter 方法时，如果 view = nil，会调用 loadView -> viewDidLoad
        view = nil
        // 清空导航栏按钮设置
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = nil
        // viewDidLoad 中进行了通知的注册，这里重新走会使通知注册两次，所以这里还需要注销通知
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - 添加 Nav 按钮方法
extension XLBaseViewController {
    
    // MARK: - 设置添加按钮方法
    /// 添加左边文字按钮
    ///
    /// - Parameters:
    ///   - title: title
    ///   - target: target
    ///   - action: action
    func addLeftTitleBarButton(title: String,
                               target: Any?,
                               action: Selector) {
        navigationItem.leftBarButtonItem = setupTitleBarButton(title: title,
                                                               target: target,
                                                               action: action)
    }
    
    /// 添加左边文字返回按钮
    ///
    /// - Parameter title: title
    func addBackTitleBarButton(title: String) {
        navigationItem.leftBarButtonItem = setupTitleBarButton(title: title,
                                                               target: self,
                                                               action: #selector(clickBackButton))
    }
    
    /// 添加左边图片返回按钮
    ///
    /// - Parameters:
    ///   - normalImageName: normalImageName
    ///   - highlightedImageName: highlightedImageName
    func addBackImageBarButton(normalImageName: String,
                               highlightedImageName: String) {
        let imageButton = UIBarButtonItem(normalImageName: normalImageName,
                                          highlightedImageName: highlightedImageName,
                                          target: self,
                                          action: #selector(clickBackButton))
        navigationItem.leftBarButtonItem = imageButton
    }
    
    /// 添加返回按钮（默认图片 + 返回文字）
    func addBackButton() {
        let barButton = UIBarButtonItem(title: "返回",
                                        normalImageName: "NavReturnIcon",
                                        highlightedImageName: "NavReturnIcon",
                                        target: self,
                                        action: #selector(clickBackButton))
        navigationItem.leftBarButtonItem = barButton
    }
    
    /// 添加右边文字按钮
    ///
    /// - Parameters:
    ///   - title: title
    ///   - target: target
    ///   - action: action
    func addRightTitleBarButton(title: String,
                                target: Any?,
                                action: Selector) {
        navigationItem.rightBarButtonItem = setupTitleBarButton(title: title,
                                                                target: target,
                                                                action: action)
    }
    
    // MARK: - 创建按钮方法
    private func setupTitleBarButton(title: String,
                                     target: Any?,
                                     action: Selector) -> UIBarButtonItem {
        let barButtonItem = UIBarButtonItem(title: title,
                                            target: target,
                                            action: action)
        return barButtonItem
    }
    
    // MARK: - 返回按钮事件
    @objc private func clickBackButton() {
        if navigationController?.childViewControllers.count == 1 {
            navigationController?.dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
}

