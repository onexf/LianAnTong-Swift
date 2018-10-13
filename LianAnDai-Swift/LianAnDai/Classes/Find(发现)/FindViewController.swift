//
//  FindViewController.swift
//  LianAnDai
//
//  Created by 王鑫锋 on 2018/10/3.
//  Copyright © 2018 王鑫锋. All rights reserved.
//

import UIKit
import WebKit

import MJRefresh

class FindViewController: UIViewController {

    lazy var webView : WKWebView = WKWebView.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.addSubview(webView)
        setWebViewConf()
        loadWebData()
        
    }
    
    
    private func setWebViewConf() {
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.scrollView.mj_header = MJRefreshHeader.init(refreshingBlock: {
            self.loadWebData()
        })

    }
    private func loadWebData() {
        let urlString = "https://pc.lianandai.com/h5/apph5/find/Translate.html"
        //创建对应NSURL
        guard let url = NSURL(string: urlString) else {
            return
        }
        let request = NSURLRequest(url: url as URL)
        webView.load(request as URLRequest)
    }
   
}


extension FindViewController : WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "prodectAction" {
            uLog(message.frameInfo)
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.scrollView.mj_header.endRefreshing()
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        webView.scrollView.mj_header.endRefreshing()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.request.url?.absoluteString == "https://pc.lianandai.com/h5/apph5/find/Translate.html" {
            decisionHandler(.allow)
        } else {
            decisionHandler(.cancel)
            let webViewController = CBWebViewController()
            if (navigationAction.request.url?.absoluteString.contains("/find/hjkz/hjkz"))! {
                //隐藏分享按钮
            } else {
                
            }
            webViewController.urlString = navigationAction.request.url?.absoluteString
            navigationController?.pushViewController(webViewController, animated: true)
        }
    }
}
