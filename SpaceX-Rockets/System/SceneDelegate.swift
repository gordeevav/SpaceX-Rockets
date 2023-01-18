//
//  SceneDelegate.swift
//  SpaceX-Rockets
//
//  Created by Aleksandr Gordeev on 17.08.2022.
//

import UIKit

// MARK: SceneDelegate
final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    // MARK: - navigationController
    private lazy var navigationController = UINavigationController() .. {
        $0.modalPresentationStyle = .fullScreen
        $0.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.appWhite]
        $0.navigationBar.setBackgroundImage(UIImage(), for: .default)
        $0.navigationBar.shadowImage = UIImage()
        $0.navigationBar.tintColor = .appWhite
    }

    // MARK: - scene
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
         
        guard let windowsScene = (scene as? UIWindowScene) else { return }
        let moduleBuilder = ModuleBuilder()
        
        let router = Router(navigationController: navigationController, assemblyBuilder: moduleBuilder)
        router.initialViewContoller()
        
        window = UIWindow(frame: windowsScene.coordinateSpace.bounds) .. {
            $0.windowScene = windowsScene
            $0.rootViewController = navigationController
            $0.makeKeyAndVisible()
        }
    }
}
