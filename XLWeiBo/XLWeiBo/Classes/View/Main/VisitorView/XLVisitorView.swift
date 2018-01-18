//
//  XLVisitorView.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/1/18.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit
import SnapKit

struct XLVisitorInfoModel {
    var imageName: String
    var message: String
    var isHome: Bool
}

class XLVisitorView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupChildrenViewInfo(model: XLVisitorInfoModel) {
        iconView.image = UIImage(named: model.imageName)
        tipLabel.text = model.message
        houseIconView.isHidden = !model.isHome
        maskIconView.isHidden = !model.isHome
        if model.isHome {
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
    // 注册按钮
    private lazy var registerButton: UIButton = UIButton()
    // 登录按钮
    private lazy var loginButton: UIButton = UIButton()
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
            make.centerY.equalToSuperview().offset(-80)
        }
        maskIconView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: ScreenWidth, height: ScreenHeight - 200))
        }
        houseIconView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(iconView).offset(-5)
        }
        tipLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(iconView.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
        }
        registerButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(-70)
            make.top.equalTo(tipLabel.snp.bottom).offset(30)
            make.size.equalTo(CGSize(width: 100, height: 35))
        }
        loginButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(70)
            make.top.equalTo(registerButton)
            make.size.equalTo(registerButton)
        }
        
        tipLabel.text = "关注一些人，回这里看看有什么惊喜"
        tipLabel.font.withSize(14)
        tipLabel.textColor = UIColor.darkGray
        tipLabel.numberOfLines = 0
        tipLabel.textAlignment = .center
        
        registerButton.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: .normal)
        registerButton.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: .highlighted)
        registerButton.setTitle("注册", for: .normal)
        registerButton.setTitleColor(UIColor.darkGray, for: .normal)
        registerButton.setTitleColor(UIColor.orange, for: .highlighted)
        
        loginButton.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: .normal)
        loginButton.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: .highlighted)
        loginButton.setTitle("登录", for: .normal)
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
