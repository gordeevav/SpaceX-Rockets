//
//  SettingsMeasurement.swift
//  SpaceX-Rockets
//
//  Created by Александр on 07.09.2022.
//

import Foundation

// MARK: MeasurementProtocol
protocol MeasurementProtocol: CaseIterable {
    static func allValues() -> [String]
    var textForRocketPropertyCell: String { get }
}

extension MeasurementProtocol {
    static func allValues() -> [String] {
        return self.allCases.map { $0.textForRocketPropertyCell }
    }
}

// MARK: LenghtMeasurement
enum LenghtMeasurement: Int, MeasurementProtocol, Codable {
    
    case meters
    case feet
        
    var textForRocketPropertyCell: String {
        switch self {
        case .meters:   return NSLocalizedString("Measure.m", comment: "")
        case .feet:     return NSLocalizedString("Measure.ft", comment: "")
        }
    }
    
    static var defaultValue: Self { .meters }
}

// MARK: WeightMeasurement

enum WeightMeasurement: Int, MeasurementProtocol, Codable {
    
    case kg
    case lb
    
    var textForRocketPropertyCell: String {
        switch self {
        case .kg:   return NSLocalizedString("Measure.kg", comment: "")
        case .lb:   return NSLocalizedString("Measure.lb", comment: "")
        }
    }
    
    static var defaultValue: Self { .kg }
}
