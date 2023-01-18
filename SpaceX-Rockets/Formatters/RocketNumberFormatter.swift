//
//  RocketNumberFormatter.swift
//  SpaceX-Rockets
//
//  Created by Aleksandr Gordeev on 30.08.2022.
//

import Foundation

struct RocketNumberFormatter {
    private let formatter = NumberFormatter() .. {
        $0.groupingSeparator = ","
        $0.numberStyle = .decimal
        $0.maximumFractionDigits = 1
    }
    
    public func string(from value: Double) -> String {
        return formatter.string(from: NSNumber(value: value)) ?? "-/-"
    }
}
