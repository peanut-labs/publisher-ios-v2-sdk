//
//  PeanutLabsConfig.swift
//  PeanutLabs-iOS
//
//  Created by Konrad Winkowski on 2/7/19.
//

import Foundation

public struct PeanutLabsConfig {
   
    internal static let domain = "www.peanutlabs.com"
    internal static let title = "Peanut Labs"
    
    internal let version: String = "2.0"
    internal let platform: String = "iOS"
    
    internal let appId: Int
    internal let appKey: String
    internal let endUserId: String
    internal let programId: String
    
    public init(appId: Int, appKey: String, endUserId: String, programId: String) {
        self.appId = appId
        self.appKey = appKey
        self.endUserId = endUserId
        self.programId = programId
    }
    
}

@objc public class PeanutLabsConfigWrapper: NSObject {
    
    internal let config: PeanutLabsConfig
    
    @objc public init(appId: Int, appKey: String, endUserId: String, programId: String) {
        self.config = PeanutLabsConfig(appId: appId, appKey: appKey, endUserId: endUserId, programId: programId)
    }
    
}
