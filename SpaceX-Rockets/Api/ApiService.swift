//
//  ApiService.swift
//  SpaceX-Rockets
//
//  Created by Александр on 24.08.2022.
//

import UIKit

// MARK: ApiServiceProtocol
protocol ApiServiceProtocol {
    func loadRocketData(completion: @escaping (Result<[RocketApiData]?, Error>) -> Void)
    func loadLaunchesData(completion: @escaping (Result<[LaunchesApiData]?, Error>) -> Void)
    func loadImage(urlPath: String, completion: @escaping (Result<UIImage?, Error>) -> Void)
}

// MARK: ApiService
final class ApiService: ApiServiceProtocol {
    
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    public func loadRocketData(completion: @escaping (Result<[RocketApiData]?, Error>) -> Void) {
        loadDecodable(endpoint: .rockets, completion: completion)
    }
    
    public func loadLaunchesData(completion: @escaping (Result<[LaunchesApiData]?, Error>) -> Void) {
        loadDecodable(endpoint: .launches, completion: completion)
    }
    
    public func loadImage(urlPath: String, completion: @escaping (Result<UIImage?, Error>) -> Void) {
        let endpoint = ApiEndpoint.image(path: urlPath)
        
        loadData(request: endpoint.request) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                if let data = data {
                    let image = UIImage(data: data)
                    completion(.success(image))
                } else {
                    completion(.failure(endpoint.emptyDataError))
                }
            }
        }
    }
}

private extension ApiService {
    
    func loadData(request: URLRequest, completion: @escaping (Result<Data?, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(data))
            }
        }.resume()
    }
    
    func loadDecodable<T: Decodable>(endpoint: ApiEndpoint, completion: @escaping (Result<T?, Error>) -> Void) {
        loadData(request: endpoint.request) { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                if let parseData = data,
                   let resultData = try? self.jsonDecoder.decode(T.self, from: parseData) {
                    completion(.success(resultData))
                } else {
                    completion(.failure(endpoint.emptyDataError))
                }
            }
        }
    }
}
