//
//  SceneDelegate.swift
//  SpaceX-Rockets
//
//  Created by Александр on 17.08.2022.
//

import UIKit

// MARK: SceneDelegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    // MARK: - navigationController
    lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        
        navigationController.modalPresentationStyle = .fullScreen
        
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.appWhite]
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.tintColor = .appWhite
        
        return navigationController
    }()

    // MARK: - scene
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
         
        guard let windowsScene = (scene as? UIWindowScene) else { return }
        
        let moduleBuilder = ModuleBuilder()
        
        let router = Router(navigationController: navigationController, assemblyBuilder: moduleBuilder)
        router.initialViewContoller()
        
        window = UIWindow(frame: windowsScene.coordinateSpace.bounds)
        window?.windowScene = windowsScene
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
