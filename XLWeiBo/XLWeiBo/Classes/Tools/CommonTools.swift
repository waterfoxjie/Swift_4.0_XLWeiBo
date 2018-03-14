//
//  CommonTools.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/1/18.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit

// MARK: - 应用程序信息
// 应用程序 ID
let WeiBoAppKey = "2969513224"
// 应用程序加密信息（开发者可以申请修改）
let WeiBoAppSecret = "877b3fb57f9dc49b6a5d92bc75631a69"
// 应用程序回调地址
let WeiBoRedirectUri = "http://www.baidu.com/"

// 系统信息
let ScreenHeight = UIScreen.main.bounds.size.height
let ScreenWidth = UIScreen.main.bounds.size.width

// 按钮文字颜色
let NormalTitleColor: UIColor = UIColor.darkGray
let HighlightedTitleColor: UIColor = UIColor.orange
// 屏幕尺寸比例
let ScreenScale = ScreenWidth / 375
// Label 行间距
let lineSpacing = 5 * ScreenScale

// MARK: - 全局通知定义
// 登录通知
let WeiBoLoginNotification = "WeiBoLoginNotification"
// 登录成功通知
let WeiBoLoginSuccessNotification = "WeiBoLoginSuccessNotification"

// MARK: - 首页 Cell 常量
// 外部间距 / 控件间的间距
let HomeCellOutterMargin: CGFloat = 12
// 顶部分隔 View 高度
let HomeCellTopViewHeight: CGFloat = 12
// 头像大小
let HomeCellIconSize: CGFloat = 40
// 底部功能 View 高度
let HomeCellBottomViewHeight: CGFloat = 35
// 文字控件宽度 / 配图视图宽度
let HomeCellLabOrPicWidth = ScreenWidth - 2 * HomeCellOutterMargin
// 图片内部间距
let HomeCellPicInnerMargin: CGFloat = 5
// 配图视图最大子控件数
let HomeCellPicMaxViewCount = 9
// 配体图视图行数
let HomeCellPicRow = 3
let HomeCellPicItemSize: CGFloat = (HomeCellLabOrPicWidth - CGFloat(HomeCellPicRow - 1) * HomeCellPicInnerMargin) / CGFloat(HomeCellPicRow)

// MARK: - Emotion 相关
// Emoticons.bundle 路径
let XLEmoticonsPath = Bundle.main.path(forResource: "Emoticons.bundle", ofType: nil)
// 微博文本字体
let wbTextFont = UIFont.systemFont(ofSize: 15)
// 被转发微博文本字体
let repostsTextFont = UIFont.systemFont(ofSize: 14)



