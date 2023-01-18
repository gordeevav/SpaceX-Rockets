//
//  ApiService.swift
//  SpaceX-Rockets
//
//  Created by Aleksandr Gordeev on 24.08.2022.
//

import UIKit

// MARK: ApiServiceProtocol
protocol ApiServiceProtocol {
    func loadRocketData(completion: @escaping (Result<[RocketApiData]?, Error>) -> Void)
    func loadLaunchesData(completion: @escaping (Result<[LaunchesApiData]?, Error>) -> Void)
}

// MARK: ApiService
final class ApiService: ApiServiceProtocol {
    
    private let jsonDecoder = JSONDecoder() .. {
        $0.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    private func loadDecodable<T: Decodable>(endpoint: ApiEndpoint, completion: @escaping (Result<T?, Error>) -> Void) {
        URLSession.shared.dataTask(with: endpoint.request) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                if let parseData = data,
                   let resultData = try? self.jsonDecoder.decode(T.self, from: parseData) {
                    completion(.success(resultData))
                } else {
                    completion(.failure(endpoint.emptyDataError))
                }
            }
        }.resume()
    }
    
    public func loadRocketData(completion: @escaping (Result<[RocketApiData]?, Error>) -> Void) {
        loadDecodable(endpoint: .rockets, completion: completion)
    }
    
    public func loadLaunchesData(completion: @escaping (Result<[LaunchesApiData]?, Error>) -> Void) {
        loadDecodable(endpoint: .launches, completion: completion)
    }
}
