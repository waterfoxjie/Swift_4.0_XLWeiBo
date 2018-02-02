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
        
        repostsString = countString(count: model.repostsCount, defaultString: "转发")
        commentString = countString(count: model.commentsCount, defaultString: "评论")
        likedString = countString(count: model.likedCount, defaultString: "赞")
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
    
}
