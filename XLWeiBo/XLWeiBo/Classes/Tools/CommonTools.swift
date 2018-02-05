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

// MARK: - 全局通知定义
// 登录通知
let WeiBoLoginNotification = "WeiBoLoginNotification"
// 登录成功通知
let WeiBoLoginSuccessNotification = "WeiBoLoginSuccessNotification"

// MARK: - 首页配图视图常量
// 外部间距
let HomePicViewOutterMargin = 11 * ScreenScale
// 内部间距
let HomePicViewInnerMargin = 3 * ScreenScale
// 配图视图大小
let HomePicViewWidth = ScreenWidth - 2 * HomePicViewOutterMargin

