//
//  Formatter.swift
//  SpaceX-Rockets
//
//  Created by Александр on 30.08.2022.
//

import Foundation

// MARK: Formatter

struct Formatter {

    private static let numberFormatter = makeNumberFormatter()
    private static let inputDateFormatter = makeInputDateFormatter()
    private static let outputDateFormatter = makeOutputDateFormatter()
    
    static func getFirstFligthFormattedString(from dateString: String) -> String {
        
        if let date = inputDateFormatter.date(from: dateString) {
            return outputDateFormatter.string(from: date)
        }
        
        return ""
    }
    
    static func numberFormat(from value: Double) -> String {
        return numberFormatter.string(from: NSNumber(value: value)) ?? "-/-"
    }
    
    static func localizedDateString(dateUnix: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(dateUnix))
        return outputDateFormatter.string(from: date)
    }
}

// MARK: Private methods
private extension Formatter {
    
    static func makeOutputDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM, YYYY"
        
        return dateFormatter
    }
    
    static func makeInputDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        return dateFormatter
    }
    
    static func makeNumberFormatter() -> NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = ","
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 1
        
        return numberFormatter
    }
}
