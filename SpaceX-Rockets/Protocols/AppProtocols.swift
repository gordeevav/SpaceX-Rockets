//
//  AppProtocols.swift
//  SpaceX-Rockets
//
//  Created by Александр on 17.10.2022.
//

import UIKit

// MARK: RouterProtocol
protocol RouterProtocol: AnyObject {
    func initialViewContoller()
    
    func showLaunches(rocketId: String, rocketName: String)
    func hideLaunches()
    
    func showSettings()
    func hideSettings()
    
    func showError(error: Error)
}

// MARK: BuilderProtocol
protocol ModuleBuilderProtocol: AnyObject {
    func rocketModule(router: RouterProtocol) -> UIViewController
    func launchesModule(rocketId: String, rocketName: String, router: RouterProtocol) -> UIViewController
    func settingsModule(router: RouterProtocol) -> UIViewController
    func errorModule(error: Error, router: RouterProtocol) -> UIViewController
}

// MARK: Rocket
protocol RocketPresenterProtocol: AnyObject {
    func showLaunches(rocketId: String, rocketName: String)
    func showSettings()
    func applySettings()
}

protocol RocketViewProtocol: LoadingViewProtocol {
    var presenter: RocketPresenterProtocol? { get set }
    func showRocketSnapshots(_ snapshots: [RocketViewDataSnapshot])
}

// MARK: Launches
protocol LaunchesPresenterProtocol: AnyObject {
    func showLaunches(rocketId: String, rocketName: String)
    func hideLaunches()
    func loadLaunchesData()
}

protocol LaunchesViewProtocol: LoadingViewProtocol {
    var presenter: LaunchesPresenterProtocol? { get set }
    func showLaunchesViewData(_ launchesViewData: LaunchesViewData)
}

// MARK: Settings
protocol SettingsPresenterProtocol: AnyObject {
    func hideSettings()
}

protocol SettingsViewProtocol: AnyObject {
    func setSettingsData(_ settingsData: SettingsData)
}

// MARK: Error
protocol ErrorPresenterProtocol: AnyObject {
    func showError(error: Error)
    func closeErrorView()
}

protocol ErrorViewProtocol: AnyObject {
    var presenter: ErrorPresenterProtocol? { get set }
    func showError(text: String)
}

// MARK: Loading
protocol LoadingViewProtocol: AnyObject {
    var activityIndicatorView: UIActivityIndicatorView { get set }
    var mainView: UIView? { get set }
}

extension LoadingViewProtocol {
    func setupLoadingViews(controllerView: UIView, mainView: UIView?) {
        controllerView.addSubview(activityIndicatorView)
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.sizeToFit()
        activityIndicatorView.color = .appWhite
    
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: controllerView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: controllerView.centerYAnchor),
            activityIndicatorView.widthAnchor.constraint(
                equalToConstant: activityIndicatorView.frame.width
            ),
            activityIndicatorView.heightAnchor.constraint(
                equalToConstant: activityIndicatorView.frame.height
            )
        ])
                
        self.mainView = mainView
    }
    
    func showLoading() {
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
        
        if let mainView = mainView {
            mainView.isHidden = true
        }
    }
    
    func hideLoading() {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
        
        if let mainView = mainView {
            mainView.isHidden = false
        }
    }
}
