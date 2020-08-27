//
//  SceneDelegate.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/8/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private lazy var coordinator = FeedFlowCoordinator(rootViewController: NavigationController())
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        coordinator.start(animated: true)
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = coordinator.rootViewController
        window?.makeKeyAndVisible()
        UINavigationBar.appearance().backIndicatorImage = Asset.backIcon.image.withRenderingMode(.alwaysOriginal)
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = Asset.backIcon.image.withRenderingMode(.alwaysOriginal)
        UINavigationBar.appearance().topItem?.backBarButtonItem =  UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        UINavigationBar.appearance().backItem?.backBarButtonItem =  UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}


