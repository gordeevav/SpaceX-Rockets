//
//  RocketsViewDataSource.swift
//  SpaceX-Rockets
//
//  Created by Aleksandr Gordeev on 19.10.2022.
//

import UIKit

final class RocketsViewDataSource: NSObject, UIPageViewControllerDataSource {
    
    private var controllers = [UIViewController]()
    private var currentPageIndex = 0
    
    public func initControllersFrom(snapshots: [RocketViewDataSnapshot], rocketButtonsDelegate: RocketButtonsDelegateProtocol) {
        controllers = snapshots.map { snapshot in
            RocketViewController() .. {
                $0.setSnapshot(snapshot)
                $0.rocketButtonsDelegate = rocketButtonsDelegate
            }
        }

        if snapshots.isEmpty || controllers.isEmpty {
            return
        }
        
        currentPageIndex = 0
    }
    
    public var currentControllers: [UIViewController]? {
        guard controllers.count > 0 else { return nil }
        return [controllers[currentPageIndex]]
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController), index > 0 else { return nil }
        currentPageIndex = index - 1
        return controllers[currentPageIndex]
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController),
                index < controllers.count - 1 else { return nil }
        currentPageIndex = index + 1
        return controllers[currentPageIndex]
    }
        
    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return controllers.count
    }
}
