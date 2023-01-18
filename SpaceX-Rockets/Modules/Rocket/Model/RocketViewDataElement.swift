//
//  RocketViewDataElement.swift
//  SpaceX-Rockets
//
//  Created by Aleksandr Gordeev on 13.09.2022.
//

import UIKit

enum RocketViewDataElement: Hashable {
        
    case image(String, UIImage?)
    case rocketTitle(String)
    case settingsButton
    case property(String, String)
    
    case rowTitle(String)
    case rowValueRegular(String)
    case rowValueBold(String)
    case rowMeasure(String)

    case launchButton(String, String)
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case let (.image(firstPath, firstImage), .image(secondPath, secondImage)):
            return (firstPath == secondPath) && (firstImage == secondImage)
        case let (.rocketTitle(first), .rocketTitle(second)): return first == second
        case (.settingsButton, .settingsButton): return true
        case let (.property(firstValue, firstMeasure), .property(secondValue, secondMeasure)):
            return (firstValue == secondValue) && (firstMeasure == secondMeasure)
        case let (.rowTitle(first), .rowTitle(second)): return first == second
        case let (.rowValueRegular(first), .rowValueRegular(second)): return first == second
        case let (.rowValueBold(first), .rowValueBold(second)): return first == second
        case let (.rowMeasure(first), .rowMeasure(second)): return first == second
        case let (.launchButton(firstId, firstName), .launchButton(secondId, secondName)):
            return (firstId == secondId) && (firstName == secondName)
        default: return false
        }
    }
}
