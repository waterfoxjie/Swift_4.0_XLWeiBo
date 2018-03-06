//
//  XLComposeTypeView.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/3/2.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit

class XLComposeTypeView: UIView {

    @IBOutlet weak var scrollView: UIScrollView!
    
    // 按钮数据数组
    private let buttonInfo = [["imageName": "composeBtn01", "title": "文字"],
                              ["imageName": "composeBtn02", "title": "照片/视频"],
                              ["imageName": "composeBtn03", "title": "长微博"],
                              ["imageName": "composeBtn04", "title": "签到"],
                              ["imageName": "composeBtn05", "title": "点评"],
                              ["imageName": "composeBtnMore", "title": "更多"],
                              ["imageName": "composeBtn06", "title": "好友圈"],
                              ["imageName": "composeBtn07", "title": "微博相机"],
                              ["imageName": "composeBtn08", "title": "音乐"],
                              ["imageName": "composeBtn09", "title": "拍摄"]]
    
    class func composeTypeView() -> XLComposeTypeView {
        let nib = UINib(nibName: "XLComposeTypeView", bundle: nil)
        let v = nib.instantiate(withOwner: nib, options: nil).last as! XLComposeTypeView
        v.frame = UIScreen.main.bounds
        return v
    }
    
    override func awakeFromNib() {
        addComposeTypeBtn()
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
    
    // 底部关闭按钮事件
    @IBAction func closeAction() {
        removeFromSuperview()
    }
}

// 添加子控件
private extension XLComposeTypeView {
    func addComposeTypeBtn() {
        
    }
    
}
