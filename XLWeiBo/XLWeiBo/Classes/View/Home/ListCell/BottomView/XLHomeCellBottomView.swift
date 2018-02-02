//
//  XLHomeCellBottomView.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/2/2.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit
import SnapKit

class XLHomeCellBottomView: UIView {
    // 转发按钮
    lazy private var repostsButton: UIButton =
        createBottomBtn(normalImage: "timeline_icon_retweet",
                        selectedImage: nil)
    // 评论按钮
    lazy private var commentButton: UIButton =
        createBottomBtn(normalImage: "timeline_icon_comment",
                        selectedImage: nil)
    // 点赞按钮
    lazy private var likedButton: UIButton =
        createBottomBtn(normalImage: "timeline_icon_unlike",
                        selectedImage: "timeline_icon_like",
                        isTitleColorDiff: true)
    
    init() {
        super.init(frame: CGRect())
        setupUI()
    }
    
    func setupInfo(model: XLHomeViewModel) {
        repostsButton.setTitle(model.repostsString, for: .normal)
        commentButton.setTitle(model.commentString, for: .normal)
        likedButton.setTitle(model.likedString, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 设置 UI
extension XLHomeCellBottomView {
    private func setupUI() {
        let topLineView = UIView()
        let middleLine1 = createMiddleLine()
        let middleLine2 = createMiddleLine()
        
        addSubview(repostsButton)
        addSubview(commentButton)
        addSubview(likedButton)
        addSubview(topLineView)
        addSubview(middleLine1)
        addSubview(middleLine2)
        
        repostsButton.snp.makeConstraints { (make) in
            make.top.leading.bottom.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        commentButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(repostsButton.snp.trailing)
            make.size.equalTo(repostsButton)
        }
        likedButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.size.equalTo(commentButton)
            make.leading.equalTo(commentButton.snp.trailing)
            make.trailing.equalToSuperview()
        }
        topLineView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(1 * ScreenScale)
        }
        middleLine1.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(repostsButton)
            make.size.equalTo(CGSize(width: 1 * ScreenScale, height: 20 * ScreenScale))
        }
        middleLine2.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(commentButton)
            make.size.equalTo(middleLine1)
        }
        
        topLineView.backgroundColor = UIColor.colorwithHexString(hexString: "#f2f2f2")
    }
}

// MARK: - 封装组件创建方法
extension XLHomeCellBottomView {
    
    /// 创建一个 Button
    ///
    /// - Parameters:
    ///   - normalImage:      normalImage
    ///   - selectedImage:    selectedImage
    ///   - isTitleColorDiff: isTitleColorDiff 文字颜色选中与未选中时是否不同
    /// - Returns: 返回创建好的 Button
    private func createBottomBtn(normalImage: String,
                                 selectedImage: String?,
                                 isTitleColorDiff: Bool = false) -> UIButton {
        let btn = UIButton()
        // 设置背景图片
        let normalBackImage = UIImage(named: "timeline_card_middle_background")
        let highlightedBackImage = UIImage(named: "timeline_card_middle_background_highlighted")
        btn.setBackgroundImage(normalBackImage, for: .normal)
        btn.setBackgroundImage(highlightedBackImage, for: .highlighted)
        // 设置图片
        btn.setImage(UIImage(named: normalImage), for: .normal)
        if selectedImage != nil {
            btn.setImage(UIImage(named: selectedImage!), for: .selected)
        }
        // 设置文字样式
        btn.setTitleColor(UIColor.lightGray, for: .normal)
        if isTitleColorDiff {
            btn.setTitleColor(UIColor.colorwithHexString(hexString: "#f33e00"), for: .selected)
        }
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14 * ScreenScale)
        // 设置文字与图片间距
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8 * ScreenScale)
        return btn
    }
    
    private func createMiddleLine() -> UIImageView {
        let line = UIImageView(image: UIImage(named: "timeline_card_bottom_line_highlighted"))
        return line
    }
}
