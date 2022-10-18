//
//  RocketPageViewController.swift
//  SpaceX-Rockets
//
//  Created by Александр on 25.08.2022.
//

import UIKit

// MARK: RocketViewController
final class RocketPageViewController: UIPageViewController {
        
    var activityIndicatorView = UIActivityIndicatorView()
    var mainView: UIView?
    var presenter: RocketPresenterProtocol?
    
    private var controllers = [RocketDataViewController]()
    private var currentPageIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        dataSource = self
        
        setupLoadingViews(controllerView: view, mainView: nil)
    }
        
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        presenter?.applySettings()
        
        if let currentPageIndex = currentPageIndex, currentPageIndex < controllers.count {
            setViewControllers([controllers[currentPageIndex]], direction: .forward, animated: false)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        updateCurrentPageIndex()
    }
}

// MARK: RocketViewProtocol
extension RocketPageViewController: RocketViewProtocol {
    
    func showRocketSnapshots(_ snapshots: [RocketViewDataSnapshot]) {
        controllers = snapshots.map { [weak self] snapshot in
            let controller = RocketDataViewController()
            controller.setSnapshot(snapshot)
            controller.rocketButtonsDelegate = self
            
            return controller
        }
        
        hideLoading()

        if snapshots.isEmpty || controllers.isEmpty { return }
        if currentPageIndex == nil {
            currentPageIndex = 0
        }
        
        setViewControllers([controllers[currentPageIndex!]], direction: .forward, animated: false)
    }
}

// MARK: RocketButtonsDelegateProtocol
extension RocketPageViewController: RocketButtonsDelegateProtocol {
    
    func settingsButtonDidPress() {
        updateCurrentPageIndex()
        presenter?.showSettings()
    }
    
    func launschesButtonDidPress(rocketId: String, rocketName: String) {
        presenter?.showLaunches(rocketId: rocketId, rocketName: rocketName)
    }
}

// MARK: Page View Controller Methods
extension RocketPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = getCurrentIndex(), index > 0 else { return nil }
        return controllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = getCurrentIndex(), index < controllers.count - 1 else { return nil }
        return controllers[index + 1]
    }
        
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return controllers.count
    }
}

private extension RocketPageViewController {
    
    func getCurrentIndex() -> Int? {
        guard let viewController = viewControllers?.first as? RocketDataViewController,
              let index = controllers.firstIndex(of: viewController)
        else { return nil }

        return index
    }
    
    func updateCurrentPageIndex() {
        currentPageIndex = getCurrentIndex()
    }
}
