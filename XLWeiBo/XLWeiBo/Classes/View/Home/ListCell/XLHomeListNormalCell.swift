//
//  XLHomeListNormalCell.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/1/31.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit
import SnapKit

private let marginWith = 11 * ScreenScale

class XLHomeListNormalCell: UITableViewCell {

    // 顶部分隔 view
    lazy private var topLineView: UIView = UIView()
    // 头像
    lazy private var iconImageView: UIImageView = UIImageView()
    // 昵称
    lazy private var nickNameLabal: UILabel = UILabel()
    // 等级
    lazy private var gradeImageView: UIImageView = UIImageView()
    // 时间
    lazy private var timeLabel: UILabel = UILabel()
    // 来源
    lazy private var sourceLabel: UILabel = UILabel()
    // 大 V 图
    lazy private var vImageView: UIImageView = UIImageView()
    // 内容
    lazy private var contactLabel: UILabel = UILabel()
    // 转发按钮
    lazy private var forwardButton: UIButton =
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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        self.selectionStyle = .none
    }
    
    // 使用模型设置界面
    func updateCellInfo(viewModel: XLHomeViewModel) {
        // 获取微博用户信息
        let userModel = viewModel.homeModel.userModel
        // 设置用户头像、昵称、V图、等级
        iconImageView.xl_setImage(urlString: userModel?.profileImageUrl,
                                  placeholderImage: UIImage(named: "avatar_default_big"),
                                  isAvatar: true)
        nickNameLabal.text = userModel?.userNickName ?? ""
        gradeImageView.image = viewModel.gradeImage
        vImageView.image = viewModel.verifiedImage
        // FIXME: 设置时间、来源
        timeLabel.text = "刚刚"
        sourceLabel.text = "来自微博 weibo.con"
        // 设置微博内容
        contactLabel.attributedText = viewModel.homeModel.wbText?.adjustLineSpacing(lineSpacing: 5 * ScreenScale)
        // FIXME: 按钮内容
        forwardButton.setTitle("转发", for: .normal)
        commentButton.setTitle("评论", for: .normal)
        likedButton.setTitle("点赞", for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

// MARK: - 设置 UI
extension XLHomeListNormalCell {
    
    private func setupUI() {
        // 底部 View
        let bottomView = UIView()
        let bottomLineView = UIView()
        let middleLine1 = createMiddleLine()
        let middleLine2 = createMiddleLine()
        
        addSubview(topLineView)
        addSubview(iconImageView)
        addSubview(nickNameLabal)
        addSubview(gradeImageView)
        addSubview(timeLabel)
        addSubview(sourceLabel)
        addSubview(vImageView)
        addSubview(contactLabel)
        addSubview(bottomLineView)
        bottomView.addSubview(forwardButton)
        bottomView.addSubview(commentButton)
        bottomView.addSubview(likedButton)
        bottomView.addSubview(middleLine1)
        bottomView.addSubview(middleLine2)
        addSubview(bottomView)
        
        topLineView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(10 * ScreenScale)
        }
        iconImageView.snp.makeConstraints { (make) in
            make.top.equalTo(topLineView.snp.bottom).offset(12 * ScreenScale)
            make.leading.equalToSuperview().offset(marginWith)
            make.size.equalTo(CGSize(width: 40 * ScreenScale, height: 40 * ScreenScale))
        }
        nickNameLabal.snp.makeConstraints { (make) in
            make.leading.equalTo(iconImageView.snp.trailing).offset(marginWith)
            make.centerY.equalTo(iconImageView.snp.centerY).offset(-10 * ScreenScale)
        }
        gradeImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(nickNameLabal)
            make.leading.equalTo(nickNameLabal.snp.trailing).offset(3 * ScreenScale)
            make.size.equalTo(CGSize(width: 14 * ScreenScale, height: 14 * ScreenScale))
        }
        timeLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(nickNameLabal)
            make.top.equalTo(nickNameLabal.snp.bottom).offset(3 * ScreenScale)
        }
        sourceLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(timeLabel)
            make.leading.equalTo(timeLabel.snp.trailing).offset(6 * ScreenScale)
        }
        vImageView.snp.makeConstraints { (make) in
            make.trailing.bottom.equalTo(iconImageView).offset(3 * ScreenScale)
            make.size.equalTo(CGSize(width: 17 * ScreenScale, height: 17 * ScreenScale))
        }
        contactLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImageView.snp.bottom).offset(marginWith)
            make.leading.equalTo(iconImageView)
            make.trailing.lessThanOrEqualToSuperview().offset(-marginWith)
            make.bottom.lessThanOrEqualTo(bottomLineView.snp.top).offset(-marginWith)
        }
        bottomLineView.snp.makeConstraints { (make) in
            make.leading.equalTo(iconImageView)
            make.trailing.equalToSuperview().offset(marginWith)
            make.bottom.equalTo(bottomView.snp.top)
            make.height.equalTo(1 * ScreenScale)
        }
        bottomView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(30 * ScreenScale)
        }
        forwardButton.snp.makeConstraints { (make) in
            make.top.leading.bottom.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        commentButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(forwardButton.snp.trailing)
            make.size.equalTo(forwardButton)
        }
        likedButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.size.equalTo(commentButton)
            make.leading.equalTo(commentButton.snp.trailing)
            make.trailing.equalToSuperview()
        }
        middleLine1.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(forwardButton)
            make.size.equalTo(CGSize(width: 1 * ScreenScale, height: 20 * ScreenScale))
        }
        middleLine2.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(commentButton)
            make.size.equalTo(middleLine1)
        }
        
        // 基础设置
        topLineView.backgroundColor = UIColor.colorwithHexString(hexString: "#f2f2f2")
        nickNameLabal.textColor = UIColor.colorwithHexString(hexString: "#f33e00")
        nickNameLabal.font = UIFont.systemFont(ofSize: 14 * ScreenScale)
        
        timeLabel.textColor = UIColor.colorwithHexString(hexString: "#ff6c00")
        timeLabel.font = UIFont.systemFont(ofSize: 12 * ScreenScale)
        
        sourceLabel.textColor = UIColor.colorwithHexString(hexString: "#828282")
        sourceLabel.font = timeLabel.font
        
        contactLabel.textColor = UIColor.black
        contactLabel.font = UIFont.systemFont(ofSize: 14 * ScreenScale)
        contactLabel.lineBreakMode = .byWordWrapping
        contactLabel.numberOfLines = 0
        
        bottomView.backgroundColor = UIColor.white
        bottomLineView.backgroundColor = UIColor.colorwithHexString(hexString: "#f2f2f2")
        
    }
}

// MARK: - 封装组件创建方法
extension XLHomeListNormalCell {
    
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














