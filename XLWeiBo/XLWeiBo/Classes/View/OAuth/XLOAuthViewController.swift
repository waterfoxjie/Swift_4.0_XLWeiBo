//
//  XLOAuthViewController.swift
//  XLWeiBo
//
//  Created by waterfoxjie on 2018/1/23.
//  Copyright © 2018年 waterfoxjie. All rights reserved.
//

import UIKit
import SVProgressHUD

class XLOAuthViewController: UIViewController {
    
    private lazy var webView = UIWebView()
    
    override func loadView() {
        setupNavBar()
        view = webView
        view.backgroundColor = UIColor.white
        
        // 设置代理
        webView.delegate = self
        webView.scrollView.isScrollEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(WeiBoAppKey)&redirect_uri=\(WeiBoRedirectUri)"
        guard let url = URL(string: urlString) else {
            return
        }
        let request = URLRequest(url: url)
        webView.loadRequest(request)
    }
}

// MARK: - 设置界面
extension XLOAuthViewController {
    private func setupNavBar() {
        title = "登录授权"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", target: self, action: #selector(close))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", target: self, action: #selector(autoFill))
    }
    
    // 关闭控制器
    @objc private func close() {
        SVProgressHUD.dismiss()
        dismiss(animated: true, completion: nil)
    }
    
    // 自动填充
    @objc private func autoFill() {
        let js = "document.getElementById('userId').value = '15521197839';" +
        "document.getElementById('passwd').value = 'qwer1234';"
        webView.stringByEvaluatingJavaScript(from: js)
        
    }
}

extension XLOAuthViewController: UIWebViewDelegate {
    
    /// 将要加载请求
    ///
    /// - Parameters:
    ///   - webView: webView
    ///   - request: 将要加载的请求
    ///   - navigationType: 导航类型
    /// - Returns: 是否加载 request
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        // 如果请求结果包含 WeiBoRedirectUri，则不继续加载
        if (request.url?.absoluteString.hasPrefix(WeiBoRedirectUri)) == false {
            return true
        }
        // 从返回的地址中查找 code=
        // query URL 中 ？ 后面所有的内容
        if request.url?.query?.hasPrefix("code=") == false {
            print("取消授权")
            close()
            return false
        }
        // 从 query 中去取出授权码（此时一定有查询字符串，并且包含 code=）
        // 这种写法得到的是一个 Optional 类型的，网络请求会出错
//        let code = String(describing: request.url?.query!["code=".endIndex...])
        let code = request.url?.query?.substring(from: "code=".endIndex)
        XLNetworkManager.shareManager.accessTokenRequest(code: code!)
        
        return false
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
}

