//
//  ApiDataItems.swift
//  SpaceX-Rockets
//
//  Created by Aleksandr Gordeev on 17.08.2022.
//

import Foundation

// MARK: RocketApiData
struct RocketApiData: Decodable {
    
    let id: String?
    let name: String?
    let costPerLaunch: Int?
    let firstFlight: String?
    let country: String?
    
    let height: LengthData?
    let diameter: LengthData?
    let mass: WeightData?
    let payloadWeights: [WeightData]?
        
    let firstStage: StageData?
    let secondStage: StageData?
    
    let flickrImages: [String]?
    
    var payload: WeightData? {
        if let payloadWeights = payloadWeights,
           let weight = payloadWeights.first(where: { ($0.id != nil) && ($0.id == "leo") }) {
            return WeightData(kg: weight.kg, lb: weight.lb)
        }
        
        return nil
    }
    
    // MARK: - LengthData
    struct LengthData: Decodable {
        let meters: Double?
        let feet: Double?
        
        func value(measure: LenghtMeasurement) -> Double? {
            return measure == .meters ? self.meters : self.feet
        }
    }

    // MARK: - WeightData
    struct WeightData: Decodable {
        var id: String? = ""
        let kg: Int?
        let lb: Int?
        
        func value(measure: WeightMeasurement) -> Int? {
            return measure == .kg ? self.kg : self.lb
        }
    }

    // MARK: - StageData
    struct StageData: Decodable {
        let engines: Int?
        let fuelAmountTons: Double?
        let burnTimeSec: Int?
    }
}

// MARK: LaunchesApiData
struct LaunchesApiData: Decodable {
    let rocket: String?
    let success: Bool?
    let name: String?
    let dateUnix: Int?
}
