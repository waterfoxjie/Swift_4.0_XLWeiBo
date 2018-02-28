//
//  XLRefreshControl.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/2/27.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit

class XLRefreshControl: UIControl {
    
    // MARK: 属性
    // weak 防止循环引用
    // 刷新控件的父视图，下拉刷新控件应适用于 UITableView、UICollectionView
    private weak var scrollView: UIScrollView?
    private lazy var refreshView: XLRefreshView = XLRefreshView.refreshView()
    
    // 构造函数
    init() {
        super.init(frame: CGRect())
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    /*
     willMove 在 addSubview 时会被调用
     - 当添加到父视图时，newSuperview 是父视图
     - 当父视图被移除时，newSuperview 是 nil
     */
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        // 判断父视图的类型
        guard let sv = newSuperview as? UIScrollView else {
            return
        }
        // 记录父视图
        scrollView = sv
        // 使用 KVO 监听父视图的 contentOffset
        scrollView?.addObserver(self, forKeyPath: "contentOffset", options: [], context: nil)
    }
    
    // 本视图从父视图上移除
    override func removeFromSuperview() {
        // superview 还存在
        // 调用父类方法之前，移除 KVO 监听
        superview?.removeObserver(self, forKeyPath: "contentOffset")
        // 执行这句之后，superview 不存在了
        super.removeFromSuperview()
    }
    
    // KVO 监听方法调用
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let sv = scrollView else {
            return
        }
        // 获取高度
        let heigth = -(sv.contentOffset.y + 64)
        // 设置刷新控件 frame
        frame = CGRect(x: 0,
                       y: -heigth,
                       width: sv.bounds.width,
                       height: heigth)
        
    }
    
    // 开始刷新
    func beginRefreshing() {
        print("开始刷新")
    }
    
    // 结束刷新
    func endRefreshing() {
        print("结束刷新")
    }
}

extension XLRefreshControl {
    private func setupUI() {
        backgroundColor = UIColor.orange
        // 超出部分不予显示
        clipsToBounds = true
        // 添加刷新视图
        addSubview(refreshView)
        // 使用原生代码进行自动布局
        refreshView.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .bottom,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: refreshView.bounds.width))
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .height,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: refreshView.bounds.height))
        
    }
}
