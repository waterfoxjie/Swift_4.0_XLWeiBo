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
    var homeInfo: XLHomeInfoModel
    
    init(model: XLHomeInfoModel) {
        self.homeInfo = model
    }
    
}
