//
//  SceneDelegate.swift
//  MySearchApp
//
//  Created by AXLT0220-AP on 2022/05/14.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController(rootViewController: ShopListViewController())
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // none
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // none
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // none
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // none
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // none
    }


}

