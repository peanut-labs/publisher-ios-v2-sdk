//
//  Tests.swift
//  PeanutLabs-iOS
//
//  Created by Derek Mordarski on 2/6/19.
//

import Foundation

internal final class Tests {
    
    let logger = PeanutLabsLogger()
    
    
    func executeTests() {
        
        logger.shouldLog = true
        logger.log(message: "..... Starting Tests.....", for: .test)
        
        // Tests go here!
        testUserId()
        testIntroUrl()
        testMD5Hash()
        
        logger.log(message: "..... Finished Tests.....", for: .test)
        
        
    }
    
    private func testUserId() {
        let plMgr = self.plMgr
        
        let result = "KonradTester-9145-3c4d6c1728"
        
        guard let userId = plMgr.userId else {
            logger.log(message: "Failed to generate userId", for: .test)
            fatalError()
        }
        
        if userId != result {
            logger.log(message: "userId missmatch \(userId) != \(result)", for: .test)
            fatalError()
        }
        
        logSuccess(funcName: "\(#function)")
    }
    
    private func testIntroUrl() {
        
        let plMgr = self.plMgr
        
        plMgr.gender = .male
        plMgr.dob = "02-05-2019"
        plMgr.programId = "testProgram"
        plMgr.add(customVariable: "test", forKey: "test")
        
        guard let url = plMgr.introURL else {
            logger.log(message: "URL was nil", for: .test)
            fatalError()
        }
        
        let result = "http://www.peanutlabs.com/userGreeting.php?userId=KonradTester-9145-3c4d6c1728&mobile_sdk=true&ref=ios_sdk&dob=02-05-2019&sex=1&program=testProgram&var_key_1=test&var_val_1=test&zl=en"
        
        if url.absoluteString != result {
            logger.log(message: "URL missmatch \(url.absoluteString) != \(result)", for: .test)
            fatalError()
        }
        
        logSuccess(funcName: "\(#function)")
    }
    
    func testMD5Hash() {
        let result = "13b182adeebaabddfe864e25df01ae6c"
        let input = "test_input"
        let output = input.md5
        
        if output != result {
            logger.log(message: "md5hash missmatch \(output) != \(result)", for: .test)
            fatalError()
        }
        
        logSuccess(funcName: "\(#function)")
    }
    
    
    private func logSuccess(funcName: String) {
        logger.log(message: "\(funcName) Succeeded", for: .test)
    }
    
    private var plMgr: PeanutLabsManager {
        let plMgr = PeanutLabsManager()
        
        plMgr.endUserId = "KonradTester"
        plMgr.appId = "9145"
        plMgr.appKey = "54dbf08d625158c6d7b055928d6ac0cc"
        
        return plMgr
    }
    
}
