//
//  PeanutLabsWebNavigationProtocol.swift
//  PeanutLabs-iOS
//
//  Created by Derek Mordarski on 2/8/19.
//

import Foundation
import WebKit

internal protocol PeanutLabsWebNavigationProtocol: AnyObject {
    
    var logger: PeanutLabsLogger { get }
    var fragment: String? { get set }
    var fragments: [String] { get }
    var baseUrl: URL? { get }
    
    func handleDecidePolicyForFailure(error: PeanutLabsErrors)
}

internal extension PeanutLabsWebNavigationProtocol {
    
    func decidePolicyFor(webView: WKWebView, request: URLRequest) -> (shouldShowLoadingIndicator: Bool?, shouldShowNavBar: Bool?, policy: WKNavigationActionPolicy) {
        
        guard let url = request.url,
            let hostStr = url.host,
            hostStr.contains(PeanutLabsConfig.domain) else {
            return (shouldShowLoadingIndicator: true, shouldShowNavBar: nil, policy: .allow)
        }
        
        if fragments.contains(url.fragment ?? "unknown") {
            fragment = url.fragment
            return (shouldShowLoadingIndicator: false, shouldShowNavBar: false, policy: .cancel)
        }
        
        if url.fragment ?? "" == "close" {
            fragment = nil
            return (shouldShowLoadingIndicator: false, shouldShowNavBar: true, policy: .cancel)
        }
        
        if url.lastPathComponent == "landingPage.php" {
            return (shouldShowLoadingIndicator: true, shouldShowNavBar: false, policy: .allow)
        }
        
        if url.path == "/userGreeting.php" && url.query?.contains("mobile_sdk=true") == false {
            let langCode = Locale.current.languageCode ?? ""
            let zlLocale = "zl=\(langCode)"
            var newUrl = baseUrl
            
            if !url.pathComponents.contains(zlLocale) {
                newUrl?.appendPathComponent("mobile_sdk=true")
                newUrl?.appendPathComponent("ref=ios_sdk")
            }
            
            guard let unewUrl = newUrl else {
                logger.log(message: "Invalid URL encountered", for: .error)
                handleDecidePolicyForFailure(error: .internalUrlGeneration)
                return (shouldShowLoadingIndicator: nil, shouldShowNavBar: nil, policy: .cancel)
            }
            
            webView.load(URLRequest(url: unewUrl))
            
            return (shouldShowLoadingIndicator: false, shouldShowNavBar: true, policy: .cancel)
            
        }
        
        return (shouldShowLoadingIndicator: true, shouldShowNavBar: nil, policy: .allow)
    }
}
