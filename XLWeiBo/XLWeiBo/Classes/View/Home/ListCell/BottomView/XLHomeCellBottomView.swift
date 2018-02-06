//
//  XLHomeCellBottomView.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/2/2.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit

class XLHomeCellBottomView: UIView {
    // 转发按钮
    @IBOutlet weak var repostsButton: UIButton!
    // 评论按钮
    @IBOutlet weak var commentButton: UIButton!
    // 点赞按钮
    @IBOutlet weak var likedButton: UIButton!
    
    var viewModel: XLHomeViewModel? {
        didSet {
            repostsButton.setTitle(viewModel?.repostsString, for: .normal)
            commentButton.setTitle(viewModel?.commentString, for: .normal)
            likedButton.setTitle(viewModel?.likedString, for: .normal)
        }
    }
}
