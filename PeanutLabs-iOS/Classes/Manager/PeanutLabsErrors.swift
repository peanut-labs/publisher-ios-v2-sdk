//
//  PeanutLabsErrors.swift
//  PeanutLabs-iOS
//
//  Created by Konrad Winkowski on 2/7/19.
//

import Foundation

@objc(PeanutLabsErrors)
public enum PeanutLabsErrors: Int {
    case sdkNotInitialized
    case noRootViewToPresentOn
    case internalUrlGeneration
}
