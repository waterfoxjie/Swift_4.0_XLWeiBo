//
//  XLHomeCellPicturesView.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/2/2.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit

private let maxViewCount = 9
private let maxRow = 3

class XLHomeCellPicturesView: UIView {
    
    // 图片 View 高度约束
    @IBOutlet weak var picturesViewHeight: NSLayoutConstraint!
    
    var urlArray: [XLHomePictureModel]? {
        didSet {
            // 设置不可见以及清除数据
            for iv in subviews {
                iv.isHidden = true
            }
            // 设置数值
            guard let urls = urlArray else {
                return
            }
            var number = 0
            for picModel in urls {
                if number > subviews.count {
                    break
                }
                let picImageView = subviews[number] as! UIImageView
                picImageView.xl_setImage(urlString: picModel.thumbnailPic, placeholderImage: UIImage(named: "avatar_default_big"))
                number = number + 1
                picImageView.isHidden = false
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
}

extension XLHomeCellPicturesView {
    private func setupUI() {
        // 创建 9 个 UIImageView
        clipsToBounds = true
        let itemSize: CGFloat = (HomePicViewWidth - CGFloat(maxRow - 1) * HomePicViewInnerMargin) / CGFloat(maxRow)
        for i in 0..<maxViewCount {
            let picImageView = UIImageView()
            addSubview(picImageView)
            // 设置位置
            let cloum = i / maxRow
            let row = i % maxRow
            let topMargin = HomePicViewOutterMargin + (itemSize + HomePicViewInnerMargin) * CGFloat(cloum)
            let leftMargin = (HomePicViewInnerMargin + itemSize) * CGFloat(row)
            picImageView.snp.makeConstraints({ (make) in
                make.top.equalToSuperview().offset(topMargin)
                make.left.equalToSuperview().offset(leftMargin)
                make.size.equalTo(CGSize(width: itemSize, height: itemSize))
            })
            picImageView.contentMode = .scaleAspectFill
            picImageView.clipsToBounds = true
        }
    }
}

/*
 // 计算九宫格宽度
 let viewsWidth = ScreenWidth - 2 * HomePicViewOutterMargin
 // 默认 Item 宽度
 let width: CGFloat = (viewsWidth - 2 * HomePicViewInnerMargin) / 3
 // 设置位置
 let cloum = number / 3
 let row = number % 3
 let topMargin = HomePicViewOutterMargin + (width + HomePicViewInnerMargin) * CGFloat(cloum)
 let leftMargin = (HomePicViewInnerMargin + width) * CGFloat(row)
 let picImageView = subviews[number] as! UIImageView
 picImageView.snp.makeConstraints({ (make) in
 make.top.equalToSuperview().offset(topMargin)
 make.left.equalToSuperview().offset(leftMargin)
 make.size.equalTo(CGSize(width: width, height: width))
 })
 picImageView.xl_setImage(urlString: picModel.thumbnailPic, placeholderImage: UIImage(named: "avatar_default_big"))
 number = number + 1
 */
