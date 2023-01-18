//
//  SettingsData.swift
//  SpaceX-Rockets
//
//  Created by Aleksandr Gordeev on 13.10.2022.
//

import Foundation

@propertyWrapper
struct Settings<T: Codable> {
    let key: String
    let defaultValue: T
    var container: UserDefaults = .standard

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            if let data = UserDefaults.standard.object(forKey: key) as? Data,
                let value = try? JSONDecoder().decode(T.self, from: data) {
                return value
            }

            return  defaultValue
        }
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: key)
            }
        }
    }
}

enum SettingsFields: Int {
    case height
    case diameter
    case weight
    case payloadWeightForLeo

    var rowTitle: String {
        switch self {
        case .height:
            return NSLocalizedString("Settings.Height", comment: "")
        case .diameter:
            return NSLocalizedString("Settings.Diameter", comment: "")
        case .weight:
            return NSLocalizedString("Settings.Weight", comment: "")
        case .payloadWeightForLeo:
            return NSLocalizedString("Settings.Payload Weight For Leo", comment: "")
        }
    }
}

struct SettingsData {
    static let settingsDidChange = "settingsDidChange"
    
    @Settings("height", defaultValue: LenghtMeasurement.defaultValue)   var height: LenghtMeasurement
    @Settings("diameter", defaultValue: LenghtMeasurement.defaultValue) var diameter: LenghtMeasurement
    @Settings("weight", defaultValue: WeightMeasurement.defaultValue)   var weight: WeightMeasurement
    @Settings("payload", defaultValue: WeightMeasurement.defaultValue)  var payload: WeightMeasurement
}
