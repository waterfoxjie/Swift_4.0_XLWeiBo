//
//  XLComposeTypeView.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/3/2.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit

private let ButtonMaxRow: CGFloat = 2
private let ButtonMaxColum: CGFloat = 3

class XLComposeTypeView: UIView {

    @IBOutlet weak var scrollView: UIScrollView!
    
    // 按钮数据数组
    private let buttonInfo = [["imageName": "composeBtn01", "title": "文字"],
                              ["imageName": "composeBtn02", "title": "照片/视频"],
                              ["imageName": "composeBtn03", "title": "长微博"],
                              ["imageName": "composeBtn04", "title": "签到"],
                              ["imageName": "composeBtn05", "title": "点评"],
                              ["imageName": "composeBtnMore", "title": "更多", "actionName": "clickMore"],
                              ["imageName": "composeBtn06", "title": "好友圈"],
                              ["imageName": "composeBtn07", "title": "微博相机"],
                              ["imageName": "composeBtn08", "title": "音乐"],
                              ["imageName": "composeBtn09", "title": "拍摄"]]
    
    class func composeTypeView() -> XLComposeTypeView {
        let nib = UINib(nibName: "XLComposeTypeView", bundle: nil)
        let v = nib.instantiate(withOwner: nib, options: nil).last as! XLComposeTypeView
        v.frame = UIScreen.main.bounds
        v.setupUI()
        return v
    }
    
    // 显示视图
    func show() {
        // 获取当前控制器的根视图
        guard let vc = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        // 将视图添加到根视图的 view 中
        vc.view.addSubview(self)
    }
    
    // 更多按钮事件
    @objc private func clickMore() {
        print("点击更多")
    }
    
    // 底部关闭按钮事件
    @IBAction func closeAction() {
        removeFromSuperview()
    }
}

// 添加子控件
private extension XLComposeTypeView {
    func setupUI() {
        // 强制刷新（目的：获取控件的正确大小）
        layoutIfNeeded()
        // 获取 scrollView 的大小
        let scrollViewRect = scrollView.bounds
        // 一屏最多可显示数量
        let showMaxCount: Int = Int(ButtonMaxRow * ButtonMaxColum)
        // 一共需要分几屏
        let viewCount = buttonInfo.count % showMaxCount > 0 ? buttonInfo.count / showMaxCount + 1 : buttonInfo.count / showMaxCount
        // 添加对应的 View
        for i in 0..<viewCount {
            let v = UIView(frame: scrollViewRect.offsetBy(dx: CGFloat(i) * scrollViewRect.width, dy: 0))
            addButtons(addView: v, fromIndex: i * showMaxCount, addCount: showMaxCount)
            // 将视图添加到 scrollView 上
            scrollView.addSubview(v)
        }
        // 设置 scrollView 属性
        scrollView.contentSize = CGSize(width: CGFloat(viewCount) * scrollViewRect.width, height: 0)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
    }
    
    /// 添加按钮
    ///
    /// - Parameters:
    ///   - addView:   需要添加按钮的 View
    ///   - fromIndex: 从第几个索引开始添加
    ///   - addCount:  需要添加的按钮个数
    func addButtons(addView: UIView, fromIndex: Int, addCount: Int) {
        // 遍历
        for i in fromIndex..<(fromIndex + addCount) {
            // 判断是否越界
            if i >= buttonInfo.count {
                break
            }
            // 获取到对应的数据
            let dict = buttonInfo[i]
            guard let imageName = dict["imageName"],
                  let title = dict["title"] else {
                continue
            }
            // 根据数据创建按钮
            let btn = XLComposeTypeButton.composeTypeButton(imageName: imageName, title: title)
            // 设置 ”更多“ 按钮点击事件
            if let actionName = dict["actionName"] {
                btn.addTarget(self, action: Selector(actionName), for: .touchUpInside)
            }
            addView.addSubview(btn)
        }
        // 遍历子视图，进行布局
        for (idx, btn) in addView.subviews.enumerated() {
            let btnSize = btn.bounds.size
            // 行间距与列间距
            let btnMargin = (addView.bounds.width - btnSize.width *  ButtonMaxColum) / (ButtonMaxColum + 1)
            let btnPadding = addView.bounds.height - btnSize.height * ButtonMaxRow
            // 获取当前对应的行、列
            let row = idx % Int(ButtonMaxColum)
            let colum = idx / Int(ButtonMaxColum)
            let btnX = btnMargin + (btnSize.width + btnMargin) * CGFloat(row)
            let btnY = (btnSize.height + btnPadding) * CGFloat(colum)
            btn.frame = CGRect(origin: CGPoint(x: btnX, y: btnY), size: btnSize)
        }
    }
}
