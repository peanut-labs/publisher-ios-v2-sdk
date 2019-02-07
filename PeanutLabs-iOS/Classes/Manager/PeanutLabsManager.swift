//
//  PeanutLabsManager.swift
//  PeanutLabs-iOS
//
//  Created by Konrad Winkowski on 2/1/19.
//

import Foundation

public final class PeanutLabsManager {
    
    
    public enum Gender {
        case male
        case female
        
        internal var paramValue: String {
            switch self {
            case .male:
                return "1"
            case .female:
                return "2"
            }
        }
    }
    
    /**
     The default singleton of the PeanutLabsManager. You can use this to quickly setup the manager and display the content.
     Before calling to present the content view you must set the following paramaters [appId, appKey, endUserId, programId]
     You can also register to the delegate(PeanutLabsManagerDelegate) to know when the view opens, closes, or if there was an error loading the page.
    **/
    public static let `default`: PeanutLabsManager = PeanutLabsManager(shouldRunTests: PeanutLabsManager.runTests)
    
    private static let runTests = true
    
    private weak var delegate: PeanutLabsManagerDelegate?
    private let logger = PeanutLabsLogger.default
    
    private var customVariables: [String: String] = [:]
    
    public var endUserId: String?
    public var appId: String?
    public var appKey: String?
    
    /** mm-dd-yyyy (ex: 02-05-2019) **/
    public var dob: String?
    /** Use PeanutLabsManager.Gender **/
    public var gender: PeanutLabsManager.Gender?
    /** An alphanumberic value **/
    public var programId: String?
    /** The Publisher Name (internal for now) **/
    internal var publisherName: String?
    
    
    
    public var isDebug: Bool = false {
        didSet {
            logger.shouldLog = isDebug
        }
    }
    
    private var urlParameters: [(key: String, value: String)] {
        var params: [(key: String, value: String)] = []
        
        if let dob = self.dob {
            let predicate = NSPredicate(format: "SELF MATCHES %@", "^[0-9]{2}-[0-9]{2}-[0-9]{4}")
            if predicate.evaluate(with: dob) {
                params.append((key: "dob", value: dob))
            }
        }
        
        if let gender = self.gender {
            params.append((key: "sex", value: gender.paramValue))
        }
        
        if let programId = self.programId {
            let predicate = NSPredicate(format: "SELF MATCHES %@", "^[a-zA-Z0-9]*$")
            if predicate.evaluate(with: programId) {
                params.append((key: "program", value: programId))
            }
        }
        
        var counter = 1
        customVariables.forEach { (key, value) in
            params.append((key: "var_key_\(counter)", value: key))
            params.append((key: "var_val_\(counter)", value: value))
            
            counter += 1
        }
        
        let locale = Locale.current
        if let code = locale.languageCode {
            params.append((key: "zl", value: code))
        }
        
        return params
    }
    
    internal lazy var userId: String? = {
        guard let endUserId = self.endUserId, let appId = self.appId, let appKey = self.appKey else {
            logger.log(message: """
                        Failed to get 'userId' because one of these required values was not provided
                        - ensUserId : \(String(describing: self.endUserId)),
                        appId : \(String(describing: self.appId)),
                        appKey : \(String(describing: self.appKey))
                        """, for: .warning)
            return nil
        }
        
        let generatedUserId = "\(endUserId)-\(appId)-\("\(endUserId)\(appId)\(appKey)".md5.prefix(10))"
        
        return generatedUserId
    }()
    
    internal var introURL: URL? {
        guard let userId = self.userId else {
            return nil
        }
        var urlStr = "http://www.peanutlabs.com/userGreeting.php?userId=\(userId)&mobile_sdk=true&ref=ios_sdk"
        
        urlParameters.forEach { (key, value) in urlStr = urlStr + "&\(key)=\(value)" }
        
        return URL(string: urlStr)
    }
    
    init(shouldRunTests: Bool = false) {
        if shouldRunTests {
            Tests().executeTests()
        }
    }
    
    /**
     Adds the custom variable(value) you want to add to the url based on the key and value ('&key=value')
     - Paramaters:
        - varaiable: The custom variable(value) to add to the URL, String must not be nill
        - key: The key for the custom variable to be used for storage and variable name in URL
    **/
    public func add(customVariable variable: String, forKey key: String) {
        customVariables[key] = variable
    }
    
    public func presentRewardsCenterOnRoot(with delegate: PeanutLabsManagerDelegate?) {
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else {
            // TODO: notify delegate of failure
            return
        }
        
        if let presentedViewController = rootViewController.presentedViewController {
            presentRewardsCenter(on: presentedViewController, with: delegate)
        } else {
            presentRewardsCenter(on: rootViewController, with: delegate)
        }
    }
    
    public func presentRewardsCenter(on viewController: UIViewController, with delegate: PeanutLabsManagerDelegate?) {
        self.delegate = delegate
        
        let rewardsCenter = PeanutLabsContentViewController()
        rewardsCenter.navigationDelegate = self
        viewController.present(rewardsCenter, animated: true) { [delegate] in
            delegate?.rewardsCenterDidOpen()
        }
    }
    
}

extension PeanutLabsManager: PeanutLabsContentViewNavigationDelegate {
    func rewardsCenterDidClose() {
        userId = nil
        delegate?.rewardsCenterDidClose()
        delegate = nil
    }
}
