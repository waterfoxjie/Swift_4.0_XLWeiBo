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
    
    // 是否是上拉刷新
    private lazy var isPullup = false
    private lazy var listViewModel = XLHomeListViewModel()
    
    override func baseSetup() {
        super.baseSetup()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "好友", target: self, action: #selector(addFriends))

        // 注册 Cell 原型
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: homeTableViewCellID)
    }
    
    // 设置数据
    override func loadData() {
        listViewModel.loadHomeList(isPullup: isPullup) { (isSuccess, isReloadData) in
            print("加载数据完成")
            self.resfreshC?.endRefreshing()
            self.isPullup = false
            if isReloadData {
                self.tableView?.reloadData()
            }
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
}

extension XLHomeViewController {
    @objc private func addFriends() {
        print("好友")
    }
}

// MARK: - UITableViewDelegate, UITableViewdataSource
extension XLHomeViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.homeList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: homeTableViewCellID, for: indexPath) as! UITableViewCell
        cell.textLabel?.text = listViewModel.homeList[indexPath.row].text
        return cell
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

