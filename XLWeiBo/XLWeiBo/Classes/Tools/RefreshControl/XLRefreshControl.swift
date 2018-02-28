//
//  XLRefreshControl.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/2/27.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit

// 设置修改控件样式临界点
private let XLRefreshChanged: CGFloat = 50

/// 刷新控件状态
///
/// - Normal:      默认状态，不做任何操作
/// - Pulling:     超越临界点，如果放手，就进行刷新
/// - WillRefresh: 超过临街点，并且已经放手
enum XLRefreshState {
    case Normal
    case Pulling
    case WillRefresh
}

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
        // 如果 < 0 则无需继续操作
        if heigth < 0 {
            return
        }
        // 设置刷新控件 frame
        frame = CGRect(x: 0,
                       y: -heigth,
                       width: sv.bounds.width,
                       height: heigth)
        // 判断是否拖拽
        if sv.isDragging {
            // 超过临界点并且为默认状态时
            if heigth > XLRefreshChanged && refreshView.refreshState == .Normal {
                print("放手刷新数据")
                // 修改状态
                refreshView.refreshState = .Pulling
            // 往上拉至临界点上方并且状态为 Pulling 时
            } else if heigth <= XLRefreshChanged && refreshView.refreshState == .Pulling {
                print("继续往下拖拽")
                refreshView.refreshState = .Normal
            }
        } else {
            // 松手
            if refreshView.refreshState == .Pulling {
                // 调用 valueChanged 事件（下拉刷新时，就会调用 loadData 方法）
                sendActions(for: .valueChanged)
            }
        }
        
    }
    
    // 开始刷新
    func beginRefreshing() {
        print("开始刷新")
        // 判断是否有父视图
        guard let sv = scrollView else {
            return
        }
        // 若还处理刷新中的状态，则不做任何处理
        if refreshView.refreshState == .WillRefresh {
            return
        }
        // 修改状态
        refreshView.refreshState = .WillRefresh
        // 修改表格顶部间距，使状态能够显示
        sv.contentInset.top += XLRefreshChanged
    }
    
    // 结束刷新
    func endRefreshing() {
        print("结束刷新")
        guard let sv = scrollView else {
            return
        }
        // 若当前不是刷新中状态，则不进行后面的操作
        if refreshView.refreshState != .WillRefresh {
            return
        }
        // 修改状态
        refreshView.refreshState = .Normal
        // 设置表格顶部间距为原来的
        sv.contentInset.top -= XLRefreshChanged
    }
}

extension XLRefreshControl {
    private func setupUI() {
        backgroundColor = superview?.backgroundColor
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
