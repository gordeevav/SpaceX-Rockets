//
//  RocketPageViewController.swift
//  SpaceX-Rockets
//
//  Created by Aleksandr Gordeev on 25.08.2022.
//

import UIKit

// MARK: RocketViewController
final class RocketsViewController: UIPageViewController {
        
    var activityIndicatorView = UIActivityIndicatorView()
    var mainView: UIView?
    
    private var rocketsDataSource = RocketsViewDataSource()
    
    public var presenter: RocketPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = rocketsDataSource
        setupLoadingViews(controllerView: view, mainView: nil)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        presenter?.applySettings()
        
        updateCurrentControllers()
    }
    
    func updateCurrentControllers() {
        if let controllers = rocketsDataSource.currentControllers {
            setViewControllers(controllers, direction: .forward, animated: false)
        }
    }
}

// MARK: RocketViewProtocol
extension RocketsViewController: RocketViewProtocol {
    func showRocketSnapshots(_ snapshots: [RocketViewDataSnapshot]) {
        rocketsDataSource.initControllersFrom(snapshots: snapshots, rocketButtonsDelegate: self)
        hideLoading()
        updateCurrentControllers()
    }
}

// MARK: RocketButtonsDelegateProtocol
extension RocketsViewController: RocketButtonsDelegateProtocol {
    
    func settingsButtonDidPress() {
        presenter?.showSettings()
    }
    
    func launschesButtonDidPress(rocketId: String, rocketName: String) {
        presenter?.showLaunches(rocketId: rocketId, rocketName: rocketName)
    }
}
