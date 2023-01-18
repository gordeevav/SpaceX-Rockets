//
//  Operators.swift
//  NinjaIceHockey
//
//  Created by Aleksandr Gordeev on 25.11.2022.
//

import Foundation

infix operator ..
func .. <T: AnyObject>(_ object: T, _ initFunction: (T) -> Void) -> T {
    initFunction(object)
    return object
}
