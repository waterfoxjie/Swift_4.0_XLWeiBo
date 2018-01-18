//
//  XLBaseViewController.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/1/17.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit

class XLBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor.white
    }
    
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
