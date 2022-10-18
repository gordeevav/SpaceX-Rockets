//
//  UIColor+.swift
//  SpaceX-Rockets
//
//  Created by Александр on 05.09.2022.
//

import UIKit

extension UIColor {
    convenience init(hexRed: UInt, hexGreen: UInt, hexBlue: UInt, hexAlpha: UInt) {
        self.init(
            red: CGFloat(hexRed) / 255.0,
            green: CGFloat(hexGreen) / 255.0,
            blue: CGFloat(hexBlue) / 255.0,
            alpha: CGFloat(hexAlpha) / 255.0
        )
    }

    static let appGray = UIColor(hexRed: 0x8E, hexGreen: 0x8E, hexBlue: 0x8E, hexAlpha: 0xFF)
    static let appWhite = UIColor.white
    static let appBlack = UIColor.black
    static let appDarkGray = UIColor(hexRed: 0x21, hexGreen: 0x21, hexBlue: 0x21, hexAlpha: 0xFF)
    static let appLightGray = UIColor(hexRed: 0xF6, hexGreen: 0xF6, hexBlue: 0xF6, hexAlpha: 0xFF)
}
