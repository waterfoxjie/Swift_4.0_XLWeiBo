//
//  XLHomeListCell.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/2/7.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit
import SnapKit

class XLHomeListCell: UITableViewCell {

    // 头像
    @IBOutlet weak var iconImageView: UIImageView!
    // 昵称
    @IBOutlet weak var nickNameLabal: UILabel!
    // 等级
    @IBOutlet weak var gradeImageView: UIImageView!
    // 时间
    @IBOutlet weak var timeLabel: UILabel!
    // 来源
    @IBOutlet weak var sourceLabel: UILabel!
    // 大 V 图
    @IBOutlet weak var vImageView: UIImageView!
    // 内容
    @IBOutlet weak var contactLabel: UILabel!
    // 图片 View
    @IBOutlet weak var picturesView: XLHomeCellPicturesView!
    // 转发微博内容
    // 这里必须设置成 ？，因为正常微博中是没有这个控件的，而这个类对应的是两个 xib 文件
    @IBOutlet weak var repostsTextLabel: UILabel?
    
    // 底部按钮
    @IBOutlet weak var bottomView: XLHomeCellBottomView!
    
    var viewModel: XLHomeViewModel? {
        // 发生改变时进行设置
        didSet {
            // 获取微博用户信息
            let userModel = viewModel?.homeModel.userModel
            
            // 设置用户头像、昵称、V图、等级
            iconImageView.xl_setImage(urlString: userModel?.profileImageUrl,
                                      placeholderImage: UIImage(named: "avatar_default_big"))
            nickNameLabal.text = userModel?.userNickName ?? ""
            gradeImageView.image = viewModel?.gradeImage
            vImageView.image = viewModel?.verifiedImage

            // FIXME: 设置时间、来源
            timeLabel.text = "刚刚"
            sourceLabel.text = "来自微博 weibo.con"

            // 设置微博内容
            contactLabel.text = viewModel?.homeModel.wbText
            
            // 设置图片 View
            picturesView.viewModel = viewModel
            
            // 设置转发微博内容
            repostsTextLabel?.text = viewModel?.repostsText
            
            // 设置底部按钮内容
            bottomView.viewModel = viewModel
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = iconImageView.bounds.width * 0.5
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
