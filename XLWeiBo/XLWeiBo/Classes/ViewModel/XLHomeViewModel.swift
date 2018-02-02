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
    }
    
}
