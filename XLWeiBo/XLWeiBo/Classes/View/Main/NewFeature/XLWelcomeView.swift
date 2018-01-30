//
//  XLWelcomeView.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/1/30.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

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
        
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
            // 更新 icon 位置
            self.layoutIfNeeded()
        }) { (_) in
            // 显示 Label
            UIView.animate(withDuration: 1.0, animations: {
                self.welcomeLabel.alpha = 1.0
            }, completion: { (_) in
                UIView.animate(withDuration: 1.0, animations: {
                    self.removeFromSuperview()
                })
            })
            
        }
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
            make.size.equalTo(CGSize(width: 90, height: 90))
        }
        welcomeLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(iconImageView.snp.bottom).offset(15)
        }
    
        backImageView.image = UIImage(named: "ad_background")
        welcomeLabel.text = "欢迎回来"
        welcomeLabel.font = UIFont.systemFont(ofSize: 17)
        welcomeLabel.textColor = UIColor.lightGray
        welcomeLabel.alpha = 0.0
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = 45
        guard let urlString = XLNetworkManager.shareManager.userAccout.avatarLargeImage else {
            return
        }
        let url = URL(string: urlString)
        iconImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "avatar_default_big"))
        
    }
}
