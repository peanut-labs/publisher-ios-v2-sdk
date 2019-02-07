//
//  PeanutLabsManagerDelegate.swift
//  PeanutLabs-iOS
//
//  Created by Konrad Winkowski on 2/1/19.
//

import Foundation

public protocol PeanutLabsManagerDelegate: AnyObject {
    func rewardsCenterDidOpen()
    func rewardsCenterDidClose()
    func peanutLabsManager(faliedWith error: PeanutLabsErrors)
}
