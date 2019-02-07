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
    @IBOutlet var webView: WKWebView?
    
    @IBOutlet var activityView: UIView?
    @IBOutlet var activityIndicator: UIActivityIndicatorView?
    
    internal weak var navigationDelegate: PeanutLabsContentViewNavigationDelegate?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        activityView?.layer.cornerRadius = 5.0
        webView?.navigationDelegate = self
    }
    
    internal func loadPage(with url: URL) {
        showLoadingIndicator()
        webView?.load(URLRequest(url: url))
    }

}

private extension PeanutLabsContentViewController {
    
    private func showLoadingIndicator() {
        activityView?.alpha = 0.0
        activityView?.isHidden = false
        
        UIView.animate(withDuration: 0.35, animations: { [activityView] in
            activityView?.alpha = 1.0
        }) { [activityIndicator] (done) in
            activityIndicator?.startAnimating()
        }
    }
    
    private func hideLoadingIndicator() {
        
        UIView.animate(withDuration: 0.15, animations: { [activityView] in
            activityView?.alpha = 0.0
        }) { [activityView, activityIndicator] (done) in
            activityView?.isHidden = true
            activityIndicator?.stopAnimating()
        }
        
    }
    
    private func update(navBardWith items: [PeanutLabsBarItem]) {
        
    }
    
}

extension PeanutLabsContentViewController: WKNavigationDelegate {
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        PeanutLabsLogger.default.log(message: "decidePolicyFor", for: .debug)
        
        decisionHandler(WKNavigationActionPolicy.allow)
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        PeanutLabsLogger.default.log(message: "didFinish", for: .debug)
        
        hideLoadingIndicator()
        
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        PeanutLabsLogger.default.log(message: "didFail", for: .debug)
        
        hideLoadingIndicator()
        
    }
    
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        PeanutLabsLogger.default.log(message: "didStartProvisionalNavigation", for: .debug)
    }
}
