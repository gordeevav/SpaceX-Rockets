//
//  RocketPresenter.swift
//  SpaceX-Rockets
//
//  Created by Aleksandr Gordeev on 18.08.2022.
//

import UIKit

// MARK: RocketPresenter
final class RocketPresenter {
      
    private let view: RocketViewProtocol
    private let router: RouterProtocol
    
    private let networkApiService: ApiServiceProtocol    
    private var rocketViewDataArray = [RocketViewData]()
    
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
        
        let numberFormatter = RocketNumberFormatter()
        let dateFormatter = RocketDateFormatter()
        
        networkApiService.loadRocketData { [weak self] rocketDataApiResult in
            DispatchQueue.main.async {
                switch rocketDataApiResult {
                case .success(let rocketNetworkDataArray):
                    if let rocketNetworkDataArray = rocketNetworkDataArray {
                        self?.rocketViewDataArray = rocketNetworkDataArray.map {
                            RocketViewData(apiData: $0, numberFormatter: numberFormatter, dateFormatter: dateFormatter)
                        }
                        self?.applySettings()
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
}
