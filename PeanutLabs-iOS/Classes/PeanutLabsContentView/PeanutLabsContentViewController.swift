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
    @IBOutlet weak var navbarHeightConstraint: NSLayoutConstraint?

    @IBOutlet var activityView: UIView?
    @IBOutlet var activityIndicator: UIActivityIndicatorView?
        
    private lazy var doneBarItem: PeanutLabsBarItem = {
        let btn = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: #selector(onDoneButton))
        return PeanutLabsBarItem(barItem: btn, position: .left, ordinal: 0) 
    }()
    
    private lazy var backBarItem: PeanutLabsBarItem = {
        let btn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.init(rawValue: 105) ?? .rewind,
                                  target: nil,
                                  action: #selector(onBackButton))
        return PeanutLabsBarItem(barItem: btn, position: .left, ordinal: 1)
    }()
    
    private lazy var forwardBarItem: PeanutLabsBarItem = {
        let btn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.init(rawValue: 106) ?? .fastForward,
                                  target: nil,
                                  action: #selector(onForwardButton))
        return PeanutLabsBarItem(barItem: btn, position: .left, ordinal: 2)
    }()
    
    private lazy var rewardCenterBarItem: PeanutLabsBarItem = {
        let btn = UIBarButtonItem(barButtonSystemItem: .stop,
                                  target: nil,
                                  action: #selector(onRewardCenterButton))
        return PeanutLabsBarItem(barItem: btn, position: .right, ordinal: 0)
    }()
    
    private lazy var fragments: [String] = {
        return ["offer", "survey", "open"]
    }()
    
    private var fragment: String?
    
    private weak var manager: PeanutLabsManager?
    private weak var navigationDelegate: PeanutLabsContentViewNavigationDelegate?
  
    internal init(manager: PeanutLabsManager, navigationDelegate: PeanutLabsContentViewNavigationDelegate?) {
        self.manager = manager
        self.navigationDelegate = navigationDelegate
        super.init(nibName: "PeanutLabsContentViewController", bundle: Bundle.init(for: PeanutLabsContentViewController.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.manager = PeanutLabsManager.default
        super.init(coder: aDecoder)
    }
    
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
    
    private func updateNavBarHeight(shouldHide: Bool) {
        let height: CGFloat = shouldHide ? 0 : 44
        
        navbarHeightConstraint?.constant = height
        UIView.animate(withDuration: 0.35) { [weak self] in
            self?.view.setNeedsLayout()
        }
        
    }
    
    @objc private func onDoneButton() {
        
    }
    
    @objc private func onRewardCenterButton() {
        
    }
    
    @objc private func onBackButton() {
        webView?.goBack()
    }
    
    @objc private func onForwardButton() {
        webView?.goForward()
    }
}

extension PeanutLabsContentViewController: WKNavigationDelegate {
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        PeanutLabsLogger.default.log(message: "decidePolicyFor", for: .debug)
        
        let request = navigationAction.request
        guard let url = request.url,
            let hostStr = url.host,
            hostStr.contains("peanutlabs.com") else {
                decisionHandler(WKNavigationActionPolicy.allow)
                showLoadingIndicator()
                return
        }
        
        
        if fragments.contains(url.fragment ?? "unknown") {
            fragment = url.fragment
            updateNavBarHeight(shouldHide: true)
            decisionHandler(WKNavigationActionPolicy.cancel)
            return
        }
        
        if url.fragment ?? "" == "close" {
            fragment = nil
            updateNavBarHeight(shouldHide: false)
            decisionHandler(WKNavigationActionPolicy.cancel)
            return
        }
        
        if url.lastPathComponent == "landingPage.php" {
            updateNavBarHeight(shouldHide: true)
        } else if url.path == "/userGreeting.php" && !url.pathComponents.contains("mobile_sdk=true") {
            
            updateNavBarHeight(shouldHide: false)
            
            let langCode = Locale.current.languageCode ?? ""
            let zlLocale = "zl=\(langCode)"
            var newUrl = URL(string: PeanutLabsManager.default.introURL?.absoluteString ?? "")
            
            if !url.pathComponents.contains(zlLocale) {
                newUrl?.appendPathComponent("mobile_sdk=true")
                newUrl?.appendPathComponent("ref=ios_sdk")
            }
            
            guard let unewUrl = newUrl else {
                
                return
            }
            
            webView.load(URLRequest(url: unewUrl))
        
            decisionHandler(WKNavigationActionPolicy.cancel)
            return
            
        }
        
        decisionHandler(WKNavigationActionPolicy.allow)
        showLoadingIndicator()
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
