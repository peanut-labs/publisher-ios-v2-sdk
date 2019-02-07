//
//  PeanutLabsContentViewController.swift
//  PeanutLabs-iOS
//
//  Created by Konrad Winkowski on 2/4/19.
//

import UIKit
import WebKit

internal protocol PeanutLabsContentViewNavigationDelegate: AnyObject {
    func rewardsCenterDidClose()
}

public final class PeanutLabsContentViewController: UIViewController {
    
    @IBOutlet var navigationBar: UINavigationBar?
    @IBOutlet var webView: WKWebView!
    
    internal weak var navigationDelegate: PeanutLabsContentViewNavigationDelegate?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
    }
    
    internal func loadPage(with url: URL) {
        
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
