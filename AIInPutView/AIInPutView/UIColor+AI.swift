//
//  UIColor+Ai.swift
//  ArtAIClassSwift
//
//  Created by mal on 2019/11/9.
//  Copyright © 2019 meishubao.com. All rights reserved.
//

import Foundation
import UIKit
public extension UIColor {

    convenience init(aiHex: Int, alpha: CGFloat = 1) {
        let red = CGFloat((aiHex & 0xFF0000) >> 16) / 255
        let green = CGFloat((aiHex & 0xFF00) >> 8) / 255
        let blue = CGFloat(aiHex & 0xFF) / 255
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
