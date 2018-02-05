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
    // 图片
    lazy private var picturesView: XLHomeCellPicturesView = XLHomeCellPicturesView()
    // 底部功能 View
    lazy private var bottomView: XLHomeCellBottomView = XLHomeCellBottomView()
    
    
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
                                  placeholderImage: UIImage(named: "avatar_default_big"))
        nickNameLabal.text = userModel?.userNickName ?? ""
        gradeImageView.image = viewModel.gradeImage
        vImageView.image = viewModel.verifiedImage
        // FIXME: 设置时间、来源
        timeLabel.text = "刚刚"
        sourceLabel.text = "来自微博 weibo.con"
        // 设置微博内容
        contactLabel.attributedText = viewModel.homeModel.wbText?.adjustLineSpacing(lineSpacing: 5 * ScreenScale, viewWidth: ScreenWidth - 2 * marginWith, textFont: contactLabel.font)
        // FIXME: 根据是否有图片进行设置
        let height = 0
        picturesView.snp.updateConstraints { (make) in
            make.height.equalTo(height)
        }
        // 按钮内容
        bottomView.setupInfo(model: viewModel)
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
        
        addSubview(topLineView)
        addSubview(iconImageView)
        addSubview(nickNameLabal)
        addSubview(gradeImageView)
        addSubview(timeLabel)
        addSubview(sourceLabel)
        addSubview(vImageView)
        addSubview(contactLabel)
        addSubview(picturesView)
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
        }
        picturesView.snp.makeConstraints { (make) in
            make.top.equalTo(contactLabel.snp.bottom)
            make.leading.equalToSuperview().offset(marginWith)
            make.trailing.equalToSuperview().offset(-marginWith)
            make.bottom.lessThanOrEqualTo(bottomView.snp.top).offset(-marginWith)
            make.height.equalTo(0)
        }
        bottomView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(35 * ScreenScale)
        }
        
        // 基础设置
        topLineView.backgroundColor = UIColor.colorwithHexString(hexString: "#f2f2f2")
        
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = 20 * ScreenScale
        
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
        
        picturesView.backgroundColor = UIColor.red
        
    }
}
















