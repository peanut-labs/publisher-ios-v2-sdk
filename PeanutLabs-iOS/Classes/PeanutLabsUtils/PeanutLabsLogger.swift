//
//  PeanutLabsLogger.swift
//  PeanutLabs-iOS
//
//  Created by Konrad Winkowski on 2/4/19.
//

import Foundation

internal enum PeanutLabsLogLevel {
    case debug
    case warning
    case error
    case test
}

internal class PeanutLabsLogger {
    
    internal static let `default`: PeanutLabsLogger = PeanutLabsLogger()
    
    internal var shouldLog: Bool = false
    
    internal func log(message: String, for level: PeanutLabsLogLevel) {
        guard shouldLog else { return }
        
        switch level {
        case .debug:
            log(debug: message)
        case .warning:
            log(warning: message)
        case .error:
            log(error: message)
        case .test:
            log(test: message)
        }
    }
    
}

private extension PeanutLabsLogger {
    private func log(debug message: String) {
        print("PeanutLabs : Debug - \(message)")
    }
    
    private func log(warning message: String) {
        print("PeanutLabs : WARNING! - \(message)")
    }
    
    private func log(error message: String) {
        print("###############################")
        print("PeanutLabs : ERROR - \(message)")
        print("###############################")
    }
    
    private func log(test message: String) {
        print("PeanutLabs : **TEST** - \(message)")
    }
}
