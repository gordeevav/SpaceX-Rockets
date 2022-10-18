//
//  RocketPresenter.swift
//  SpaceX-Rockets
//
//  Created by Александр on 18.08.2022.
//

import UIKit

// MARK: RocketPresenter
final class RocketPresenter {
      
    private let view: RocketViewProtocol
    private let router: RouterProtocol
    
    private let networkApiService: ApiServiceProtocol
    
    private var rocketViewDataArray = [RocketViewData]()
    private var rocketImages = [String: UIImage]()
    
    init(view: RocketViewProtocol, networkApiService: ApiServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
        self.networkApiService = networkApiService
        
        NotificationCenter.default.addObserver(
            self,selector: #selector(applySettings),
            name: NSNotification.Name(SettingsData.settingsDidChange),
            object: nil
        )
    }
    
    public func setImage(rocketId: String, image: UIImage?) {
        guard let rocketViewData = rocketViewDataArray.first(where: { $0.rocketId == rocketId })
        else { return }
        rocketViewData.rocketImage = image
    }
    
    @objc public func applySettings() {
        let settingsData = SettingsData()
        let snapshots = rocketViewDataArray.map { $0.makeSnapshot(settingsData: settingsData) }
        view.showRocketSnapshots(snapshots)
    }
}

// MARK: Protocol Realisation
extension RocketPresenter: RocketPresenterProtocol {
    public func showLaunches(rocketId: String, rocketName: String) {
        router.showLaunches(rocketId: rocketId, rocketName: rocketName)
    }
    
    public func showSettings() {
        router.showSettings()
    }
}

// MARK: Methods
extension RocketPresenter {
    
    public func startLoadingRocketData() {
        view.showLoading()
        
        networkApiService.loadRocketData { [weak self] rocketDataApiResult in
            DispatchQueue.main.async {
                switch rocketDataApiResult {
                case .success(let rocketNetworkDataArray):
                    if let rocketNetworkDataArray = rocketNetworkDataArray {
                        self?.rocketViewDataArray = rocketNetworkDataArray.map { RocketViewData(rocketApiData: $0) }
                        self?.applySettings()
                        self?.startLoadingImages()
                    }
                case .failure(let error):
                    switch error {
                    case ApiError.emptyImageData, ApiError.emptyLaunchesData, ApiError.emptyRocketData: return
                    default: self?.router.showError(error: error)
                    }
                }
            }
        }
    }
    
    public func startLoadingImages() {
        rocketViewDataArray.forEach { rocketViewData in
            let randomImageUrl = rocketViewData.randomImageUrl
            if rocketViewData.rocketId.isEmpty || randomImageUrl.isEmpty {
                return
            }
                        
            networkApiService.loadImage(urlPath: randomImageUrl) { [weak self] imageResult in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    switch imageResult {
                    case .success(let image):
                        if let image = image {
                            self.setImage(rocketId: rocketViewData.rocketId, image: image)
                            self.applySettings()
                        }
                    case .failure(let error):
                        self.router.showError(error: error)
                    }
                }
            }
        }
    }
}
