//
//  XLBaseViewController.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/1/17.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit

class XLBaseViewController: UIViewController {
    
    lazy var userLogon: Bool = false
    
    var tableView: UITableView?
    var resfreshC: UIRefreshControl?
    var visitorInfoModel: XLVisitorInfoModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // 需要被重写的方法不能写在 extension 中
    func setupUI() {
        view.backgroundColor = UIColor.white
        userLogon ? setupTableView() : setupVisitorView()
    }
    
    // 加载数据
    @objc func loadData() {
        // 默认收起
        self.resfreshC?.endRefreshing()
    }
}

// MARK: - 设置界面
extension XLBaseViewController {
    
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
    }
    
    // 设置访客视图
    private func setupVisitorView() {
        let visitorView = XLVisitorView(frame: view.bounds)
        visitorView.backgroundColor = UIColor(red: 237.0 / 255.0, green: 237.0 / 255.0, blue: 237.0 / 255.0, alpha: 1.0)
        visitorView.setupChildrenViewInfo(model: visitorInfoModel!)
        view.addSubview(visitorView)
        
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

