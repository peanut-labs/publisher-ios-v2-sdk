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
    func handleFailure(error: PeanutLabsErrors)
}

public final class PeanutLabsContentViewController: UIViewController, PeanutLabsWebNavigationProtocol {
    
    

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
    
    internal lazy var fragments: [String] = {
        return ["offer", "survey", "open"]
    }()
    
    internal var logger: PeanutLabsLogger {
        return PeanutLabsLogger.default
    }
    internal var fragment: String?
    internal var baseUrl: URL? {
        return manager?.introURL
    }
    
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
        webView?.load(URLRequest(url: url))
    }
    
    func handleDecidePolicyForFailure(error: PeanutLabsErrors) {
        navigationDelegate?.handleFailure(error: error)
    }

}

private extension PeanutLabsContentViewController {
    
    private func showLoadingIndicator() {
        
        guard activityView?.isHidden == true else { return }
        
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
  
        let results = decidePolicyFor(webView: webView, request: navigationAction.request)
        
        if results.shouldShowLoadingIndicator == true {
            showLoadingIndicator()
        }
        
        if let shouldShowNavBar = results.shouldShowNavBar {
            updateNavBarHeight(shouldHide: !shouldShowNavBar)
        }
        
        decisionHandler(results.policy)
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
