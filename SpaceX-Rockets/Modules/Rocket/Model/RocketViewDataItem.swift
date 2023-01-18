//
//  RocketViewDataItem.swift
//  SpaceX-Rockets
//
//  Created by Aleksandr Gordeev on 17.10.2022.
//

import Foundation

struct RocketViewDataItem: Identifiable, Hashable {
    let id = UUID()
    var data: RocketViewDataElement
    
    init(_ data: RocketViewDataElement) {
        self.data = data
    }
}
