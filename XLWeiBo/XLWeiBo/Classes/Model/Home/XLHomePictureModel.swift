//
//  XLHomePictureModel.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/2/5.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit
import ObjectMapper

class XLHomePictureModel: Mappable {
    
    var thumbnailPic: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        thumbnailPic <- map["thumbnail_pic"]
    }
    
}
