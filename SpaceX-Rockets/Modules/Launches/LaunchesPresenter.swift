//
//  LaunchesPresenter.swift
//  SpaceX-Rockets
//
//  Created by Aleksandr Gordeev on 25.08.2022.
//

import Foundation

// MARK: LaunchesPresenter
final class LaunchesPresenter: LaunchesPresenterProtocol {
    
    private let view: LaunchesViewProtocol
    private let router: RouterProtocol
    
    private let apiService: ApiServiceProtocol
    private var apiLaunchesDataArray: [LaunchesApiData]?
    
    private var rocketId = ""
    private var rocketName = ""
    
    init(view: LaunchesViewProtocol, apiService: ApiServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
        self.apiService = apiService
    }
    
    func showLaunches(rocketId: String, rocketName: String) {
        self.rocketName = rocketName
        self.rocketId = rocketId
        
        refresh()
    }
    
    func hideLaunches() {
        router.hideLaunches()
    }
    
    func refresh() {
        guard let apiLaunchesDataArray = apiLaunchesDataArray else { return }
        let launches = apiLaunchesDataArray.filter { $0.rocket == rocketId }
        
        view.showLaunchesViewData(
            LaunchesViewData(rocketName: rocketName, launcesApiData: launches)
        )
    }
    
    func loadLaunchesData() {
        view.showLoading()
            
        apiService.loadLaunchesData { [weak self] launchesDataApiResult in
            DispatchQueue.main.async {
                switch launchesDataApiResult {
                case .success(let launches):
                    self?.apiLaunchesDataArray = launches
                    self?.refresh()
                case .failure(let error):
                    self?.router.showError(error: error)
                }
            }
        }
    }
}
