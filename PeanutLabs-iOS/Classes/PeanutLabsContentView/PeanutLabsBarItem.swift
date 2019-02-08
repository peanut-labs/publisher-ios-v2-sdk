//
//  PeanutLabsBarItem.swift
//  PeanutLabs-iOS
//
//  Created by Konrad Winkowski on 2/4/19.
//

import UIKit

internal enum BarItemPosition {
    case left
    case right
}

internal struct PeanutLabsBarItem {
    let barItem: UIBarButtonItem
    let position: BarItemPosition
    let ordinal: Int8
}
