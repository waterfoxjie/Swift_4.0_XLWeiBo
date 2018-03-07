//
//  XLTitleViewController.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/3/6.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit

class XLTitleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "文字"
        view.backgroundColor = UIColor.yellow
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", target: self, action: #selector(comeBack))
    }
    
    @objc private func comeBack() {
        dismiss(animated: true, completion: nil)
    }

}
