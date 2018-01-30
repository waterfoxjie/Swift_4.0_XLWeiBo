//
//  XLWelcomeView.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/1/30.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit
import SnapKit

/// 欢迎界面
class XLWelcomeView: UIView {

    lazy var backImageView: UIImageView = UIImageView()
    lazy var iconImageView: UIImageView = UIImageView()
    lazy var welcomeLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = UIScreen.main.bounds
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        // 根据当前约束更新控件位置
        self.layoutIfNeeded()
        // 更新约束
        self.iconImageView.snp.updateConstraints({ (make) in
            make.bottom.equalTo(self).offset(-(bounds.height - 250))
        })
        
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0,
                       options: [],
                       animations: {
                        self.layoutIfNeeded()},
                       completion: nil)
    }
}

// MARK: - 设置界面
extension XLWelcomeView {
    private func setupUI() {
        addSubview(backImageView)
        addSubview(iconImageView)
        addSubview(welcomeLabel)
        
        backImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        iconImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-200)
            make.size.equalTo(CGSize(width: 85, height: 85))
        }
        welcomeLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(iconImageView.snp.bottom).offset(15)
        }
        
        backImageView.image = UIImage(named: "ad_background")
        iconImageView.image = UIImage(named: "avatar_default_big")
        welcomeLabel.text = "欢迎回来"
        welcomeLabel.font = UIFont.systemFont(ofSize: 17)
        welcomeLabel.textColor = UIColor.lightGray
    }
}
