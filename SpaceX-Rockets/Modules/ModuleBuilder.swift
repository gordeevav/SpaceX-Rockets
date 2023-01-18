//
//  ModuleBuilder.swift
//  SpaceX-Rockets
//
//  Created by Aleksandr Gordeev on 22.08.2022.
//

import UIKit

// MARK: ModuleBuilder
final class ModuleBuilder: ModuleBuilderProtocol {
    
    private let apiService = ApiService()
    
    // MARK: - rocketModule
    func rocketModule(router: RouterProtocol) -> UIViewController {
        let view = RocketsViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        let presenter = RocketPresenter(view: view, networkApiService: apiService, router: router)
        
        view.presenter = presenter
        presenter.startLoadingRocketData()
        
        return view
    }
    
    // MARK: - launchesModule
    func launchesModule(rocketId: String, rocketName: String, router: RouterProtocol) -> UIViewController {
        var launchesView: LaunchesViewController
        var launchesPresenter: LaunchesPresenterProtocol?
                
        launchesView = LaunchesViewController()
        launchesPresenter = LaunchesPresenter(view: launchesView, apiService: apiService, router: router)
        launchesView.presenter = launchesPresenter
        
        launchesPresenter?.loadLaunchesData()
        
        launchesView.title = rocketName
        launchesPresenter?.showLaunches(rocketId: rocketId, rocketName: rocketName)
                
        return launchesView
    }
    
    // MARK: - settingsModule
    func settingsModule(router: RouterProtocol) -> UIViewController {
        let view = SettingsViewController()
        
        let presenter = SettingsPresenter(view: view, router: router)
        view.presenter = presenter
        
        let navigationViewController = UINavigationController(rootViewController: view)
        
        return navigationViewController
    }
    
    // MARK: - errorModule
    func errorModule(error: Error, router: RouterProtocol) -> UIViewController {
        let view = ErrorViewController()
        
        let presenter = ErrorPresenter(view: view, router: router)
        view.presenter = presenter
        
        presenter.showError(error: error)
   
        return view
    }
}
