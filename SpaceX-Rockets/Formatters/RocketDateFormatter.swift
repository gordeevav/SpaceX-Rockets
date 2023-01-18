//
//  RocketDateFormatter.swift
//  SpaceX-Rockets
//
//  Created by Aleksandr Gordeev on 19.10.2022.
//

import Foundation

struct RocketDateFormatter {
    private let outputFormatter = DateFormatter() .. {
        $0.dateFormat = "d MMMM, YYYY"
    }
    
    private let inputFormatter = DateFormatter() .. {
        $0.dateFormat = "YYYY-MM-dd"
    }
    
    public func firstFlightString(from dateString: String) -> String {
        guard let date = inputFormatter.date(from: dateString) else { return "" }
        return outputFormatter.string(from: date)
    }
    
    public func localizedDateString(dateUnix: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(dateUnix))
        return outputFormatter.string(from: date)
    }
}
