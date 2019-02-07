//
//  PeanutLabsContentViewController.swift
//  PeanutLabs-iOS
//
//  Created by Konrad Winkowski on 2/4/19.
//

import UIKit
import WebKit

public final class PeanutLabsContentViewController: UIViewController {
    
    @IBOutlet var navigationBar: UINavigationBar?
    @IBOutlet var webView: WKWebView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
    }

}

private extension PeanutLabsContentViewController {
    
    private func showLoadingIndicator() {
        
    }
    
    private func hideLoadingIndicator() {
        
    }
    
    private func update(navBardWith items: [PeanutLabsBarItem]) {
        
    }
    
}

extension PeanutLabsContentViewController: WKNavigationDelegate {
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
    
}
