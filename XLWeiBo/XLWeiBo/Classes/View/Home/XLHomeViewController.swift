//
//  XLHomeViewController.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/1/17.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit

private let homeTableViewCellID = "homeTableViewCellID"

class XLHomeViewController: XLBaseViewController {
    
    private lazy var dataArray = [String]()
    private lazy var isPullup = false
    
    override func setupUI() {
        super.setupUI()

        // 注册 Cell 原型
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: homeTableViewCellID)

    }
    
    override func loadData() {
        // 模拟延迟
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            for i in 1..<10 {
                if self.isPullup {
                    self.dataArray.append("上拉\(i)")
                } else {
                    self.dataArray.insert("下拉\(i)", at: 0)
                }
            }
            self.resfreshC?.endRefreshing()
            self.tableView?.reloadData()
            self.isPullup = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
}

extension XLHomeViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: homeTableViewCellID)
        cell?.textLabel?.text = self.dataArray[indexPath.row]
        return cell!
    }
    
    // 将要显示 cell 代理方法
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 判断 indexPath 是否是最后一组的最后一行
        let row = indexPath.row
        let section = tableView.numberOfSections - 1
        // 没有数据的情况
        if row < 0 || section < 0 {
            return
        }
        let count = tableView.numberOfRows(inSection: section)
        if row == (count - 1) && !isPullup {
            // 做上拉刷新
            isPullup = true
            loadData()
        }
    }
    
    
}

