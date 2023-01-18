//
//  Router.swift
//  SpaceX-Rockets
//
//  Created by Aleksandr Gordeev on 24.08.2022.
//

import UIKit

// MARK: Router
final class Router: RouterProtocol {
    
    private let navigationController: UINavigationController
    private let moduleBuilder: ModuleBuilderProtocol
    
    init(navigationController: UINavigationController, assemblyBuilder: ModuleBuilderProtocol) {
        self.navigationController = navigationController
        self.moduleBuilder = assemblyBuilder
    }
    
    // MARK: - Main
    func initialViewContoller() {
        let mainViewController = moduleBuilder.rocketModule(router: self)
        navigationController.viewControllers = [mainViewController]
    }
    
    
    // MARK: - Launches
    func showLaunches(rocketId: String, rocketName: String) {
        let viewController = moduleBuilder.launchesModule(rocketId: rocketId, rocketName: rocketName, router: self)
        navigationController.show(viewController, sender: nil)
    }

    func hideLaunches() {
        navigationController.popToRootViewController(animated: true)
    }
    
    // MARK: - Settings
    func showSettings() {
        let settingsViewController = moduleBuilder.settingsModule(router: self)
        navigationController.present(settingsViewController, animated: true)
    }
    
    func hideSettings() {
        navigationController.dismiss(animated: true)
    }

    // MARK: - Error
    func showError(error: Error) {
        let errorViewController = moduleBuilder.errorModule(error: error, router: self)
        navigationController.popToRootViewController(animated: false)
        navigationController.viewControllers = [errorViewController]
    }
}
