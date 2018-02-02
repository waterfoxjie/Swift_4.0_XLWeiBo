//
//  XLHomeListNormalCell.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/1/31.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit
import SnapKit

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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    // 使用模型设置界面
    func updateCellInfo(viewModel: XLHomeViewModel) {
        // 获取微博用户信息
        let userModel = viewModel.homeModel.userModel
        // 设置用户头像、昵称、V图、等级
        nickNameLabal.text = userModel?.userNickName ?? ""
        gradeImageView.image = viewModel.gradeImage
        vImageView.image = viewModel.verifiedImage
        // FIXME: 设置时间、来源
        timeLabel.text = "刚刚"
        sourceLabel.text = "来自微博 weibo.con"
        // 设置微博内容
        contactLabel.attributedText = viewModel.homeModel.wbText?.adjustLineSpacing(lineSpacing: 5 * ScreenScale)
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
        
        topLineView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: ScreenWidth, height: 10 * ScreenScale))
        }
        iconImageView.snp.makeConstraints { (make) in
            make.top.equalTo(topLineView.snp.bottom).offset(12 * ScreenScale)
            make.leading.equalToSuperview().offset(11 * ScreenScale)
            make.size.equalTo(CGSize(width: 40 * ScreenScale, height: 40 * ScreenScale))
        }
        nickNameLabal.snp.makeConstraints { (make) in
            make.leading.equalTo(iconImageView.snp.trailing).offset(11 * ScreenScale)
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
            make.top.equalTo(iconImageView.snp.bottom).offset(11 * ScreenScale)
            make.leading.equalTo(iconImageView)
            make.trailing.lessThanOrEqualToSuperview().offset(-11 * ScreenScale)
            make.bottom.lessThanOrEqualToSuperview().offset(-11 * ScreenScale)
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
    }
}














