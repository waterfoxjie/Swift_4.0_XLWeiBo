//
//  XLHomeViewModel.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/2/1.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit

/// 单条微博视图模型
class XLHomeViewModel {
    // 单条微博数据模型
    var homeModel: XLHomeInfoModel
    // 会员图标
    var gradeImage: UIImage?
    // V 图标
    var verifiedImage: UIImage?
    // 配图视图高度
    var picViewsSize: CGSize = CGSize()
    // 配图视图内容
    var picUrlArray: [XLHomePictureModel]? {
        // 转发的微博正文一定没有图片，所以先看看转发微博中是否有图片，有则返回，没有就返回正文中的配图，都没有则返回 nil
        return homeModel.retweetedStatus?.pictureArray ?? homeModel.pictureArray
    }
    // 被转发微博文字
    var repostsText: String?
    // 转发文字
    var repostsString: String?
    // 评论文字
    var commentString: String?
    // 点赞文字
    var likedString: String?
    
    init(model: XLHomeInfoModel) {
        self.homeModel = model
        
        if let rankNum = model.userModel?.mbRank {
            var gradeImageName = "common_icon_membership_expired"
            if rankNum != 0 {
                gradeImageName = "common_icon_membership_level\(rankNum)"
            }
            gradeImage = UIImage(named: gradeImageName)
        }
        
        // -1：没有认证，0：认证用户，2，3，5：企业认证，220：达人
        switch model.userModel?.verifiedType ?? -1 {
        case 0:
            verifiedImage = UIImage(named: "avatar_vip")
        case 2,3,5:
            verifiedImage = UIImage(named: "avatar_enterprise_vip")
        case 220:
            verifiedImage = UIImage(named: "avatar_grassroot")
        default:
            break
        }
        
        // 设置配图视图高度
        let picViewsHeight = calcPicViewsHeight(picCount: model.retweetedStatus?.pictureArray?.count ?? model.pictureArray?.count)
        picViewsSize = CGSize(width: HomePicViewWidth, height: picViewsHeight)
        
        // 设置被转发微博文字
        repostsText = "@\(String(describing: model.retweetedStatus?.userModel?.userNickName ?? "")) : "
            + "\(String(describing: model.retweetedStatus?.wbText ?? ""))"
        
        // 底部按钮文字
        repostsString = countString(count: model.repostsCount, defaultString: "转发")
        commentString = countString(count: model.commentsCount, defaultString: "评论")
        likedString = countString(count: model.likedCount, defaultString: "赞")
    }
    
    
    /// 修改单张配图视图大小
    ///
    /// - Parameter image: 图片
    func updateSingleImageSize(image: UIImage) {
        var imageSize = image.size
        imageSize.height += HomePicViewOutterMargin * 2
        picViewsSize = imageSize
    }
    
    /// 给定一个数字，返回对应的描述结果
    ///
    /// - Parameters:
    ///   - count:         count  数字
    ///   - defaultString: defaultString  默认字符串，转发 / 评论 / 赞
    /// - Returns: 返回描述结果
    private func countString(count: Int, defaultString: String) -> String {
        if count == 0 {
            return defaultString
        }
        if count < 10000 {
            return count.description
        }
        return String(format: "%.2f 万", Double(count) / 10000)
    }
    
    
    /// 返回配图视图高度
    ///
    /// - Parameter picCount: 图片数
    /// - Returns:  返回对应的高度
    private func calcPicViewsHeight(picCount: Int?) -> CGFloat {
        if picCount == 0 || picCount == nil {
            return 0
        }
        // 默认 Item 宽度
        let width: CGFloat = (HomePicViewWidth - 2 * HomePicViewInnerMargin) / 3
        // 根据 picCount 知道有多少行
        let row = (picCount! - 1) / 3 + 1
        var picHeight = HomePicViewOutterMargin * 2
        picHeight = picHeight + HomePicViewInnerMargin * CGFloat(row - 1)
        picHeight = picHeight + width * CGFloat(row)
        return picHeight
    }
    
}
