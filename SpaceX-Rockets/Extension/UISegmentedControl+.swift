//
//  UISegmentedControl+.swift
//  SpaceX-Rockets
//
//  Created by Aleksandr Gordeev on 07.09.2022.
//

import Foundation
import UIKit

extension UISegmentedControl {
    func setItems(_ items: [String]) {
        self.removeAllSegments()
        
        for (index, item) in items.enumerated() {
            self.insertSegment(withTitle: item, at: index, animated: false)
        }
    }
}
