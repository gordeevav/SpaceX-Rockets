//
//  ApiEndpoint.swift
//  SpaceX-Rockets
//
//  Created by Aleksandr Gordeev on 17.08.2022.
//

import Foundation
import UIKit

// MARK: ApiError
enum ApiError: Error {
    case invalidResponse
    
    case emptyRocketData
    case emptyLaunchesData
    case emptyImageData
}

// MARK: ApiEndpoint
enum ApiEndpoint {
    case rockets
    case launches
    case image(path: String)
    
    var baseUrl: String { "https://api.spacexdata.com/v4/" }
    
    var path: String {
        switch self {
        case .rockets: return baseUrl + "rockets"
        case .launches: return baseUrl + "launches"
        case .image(let imagePath): return imagePath
        }
    }

    var request: URLRequest {
        let url = URL(string: path)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
    
    var emptyDataError: ApiError {
        switch self {
        case .rockets: return .emptyRocketData
        case .launches: return .emptyLaunchesData
        case .image: return .emptyImageData
        }
    }
}
