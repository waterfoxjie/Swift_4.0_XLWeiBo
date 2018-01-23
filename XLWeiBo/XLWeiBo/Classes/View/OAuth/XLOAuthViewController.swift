//
//  XLOAuthViewController.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/1/23.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit

class XLOAuthViewController: UIViewController {
    
    private lazy var webView = UIWebView()
    
    override func loadView() {
        
        setupNavBar()
        view = webView
        view.backgroundColor = UIColor.white
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        // Do any additional setup after loading the view.
    }

}

// MARK: - 设置界面
extension XLOAuthViewController {
    private func setupNavBar() {
        title = "登录授权"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", target: self, action: #selector(close))
    }
    
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }
}
