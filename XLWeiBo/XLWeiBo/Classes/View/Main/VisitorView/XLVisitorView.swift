//
//  XLVisitorView.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/1/18.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit
import SnapKit

class XLVisitorView: UIView {
    
    // 注册按钮
    lazy var registerButton: UIButton = UIButton()
    // 登录按钮
    lazy var loginButton: UIButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 设置控件的值
    func setupChildrenViewInfo(dict: [String: Any]) {
        guard let imageName = dict["imageName"] as? String,
              let message = dict["message"] as? String,
              let isHome = dict["isHome"] as? Bool else {
                return
        }
        iconView.image = UIImage(named: imageName)
        tipLabel.text = message
        houseIconView.isHidden = !isHome
        maskIconView.isHidden = !isHome
        if isHome {
            startAnimation()
        }
    }
    
    // MARK: - 懒加载私有控件
    // 图像
    private lazy var iconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    // 首页小房子
    private lazy var houseIconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
    // 提示 label
    private lazy var tipLabel: UILabel = UILabel()
    // 遮罩层
    private lazy var maskIconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
}

// MARK: - 设置界面
extension XLVisitorView {
    private func setupUI() {
        // 添加控件
        addSubview(iconView)
        addSubview(maskIconView)
        addSubview(houseIconView)
        addSubview(tipLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        
        // 自动布局
        iconView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-80 * ScreenScale)
        }
        maskIconView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: ScreenWidth, height: (ScreenHeight - 200) * ScreenScale))
        }
        houseIconView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(iconView).offset(-5 * ScreenScale)
            make.size.equalTo(CGSize(width: 92 * ScreenScale, height: 90 * ScreenScale))
        }
        tipLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconView.snp.bottom).offset(25 * ScreenScale)
            make.left.equalToSuperview().offset(15 * ScreenScale)
            make.right.equalToSuperview().offset(-15 * ScreenScale)
        }
        registerButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(-70 * ScreenScale)
            make.top.equalTo(tipLabel.snp.bottom).offset(30 * ScreenScale)
            make.size.equalTo(CGSize(width: 100 * ScreenScale, height: 35 * ScreenScale))
        }
        loginButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(70 * ScreenScale)
            make.top.equalTo(registerButton)
            make.size.equalTo(registerButton)
        }
        
        tipLabel.text = "关注一些人，回这里看看有什么惊喜"
        tipLabel.font = UIFont.systemFont(ofSize: 16 * ScreenScale)
        tipLabel.textColor = UIColor.darkGray
        tipLabel.numberOfLines = 0
        tipLabel.textAlignment = .center
        
        registerButton.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: .normal)
        registerButton.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: .highlighted)
        registerButton.setTitle("注册", for: .normal)
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 16 * ScreenScale)
        registerButton.setTitleColor(UIColor.darkGray, for: .normal)
        registerButton.setTitleColor(UIColor.orange, for: .highlighted)
        
        loginButton.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: .normal)
        loginButton.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: .highlighted)
        loginButton.setTitle("登录", for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 16 * ScreenScale)
        loginButton.setTitleColor(UIColor.darkGray, for: .normal)
        loginButton.setTitleColor(UIColor.orange, for: .highlighted)
    }
    
    // 旋转动画
    private func startAnimation() {
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = 2 * Double.pi
        anim.repeatCount = MAXFLOAT
        anim.duration = 15
        // 设置完成之后不删除
        anim.isRemovedOnCompletion = false
        // 动画添加到图层
        iconView.layer.add(anim, forKey: nil)
    }
}
