//
//  UIFont+.swift
//  SpaceX-Rockets
//
//  Created by Александр on 23.09.2022.
//

import UIKit

extension UIFont {
    static func labGrotesqueFontRegular(ofSize size: CGFloat) -> UIFont {
        UIFont(name: "LabGrotesque-Regular", size: size) ?? .systemFont(ofSize: size)
    }

    static func labGrotesqueFontBold(ofSize size: CGFloat) -> UIFont {
        UIFont(name: "LabGrotesque-Bold", size: size) ?? .systemFont(ofSize: size)
    }
}
