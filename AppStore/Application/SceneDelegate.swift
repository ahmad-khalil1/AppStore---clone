//
//  SceneDelegate.swift
//  AppStore
//
//  Created by ahmad$$ on 2/14/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = creatTabBarContoller()
        window?.makeKeyAndVisible()
        
    }
    
    func createSearchNC() -> UINavigationController {
        let searchNC = AppSearchVC()
        let navController = UINavigationController(rootViewController: searchNC)
        
        searchNC.title = "Search"
        navController.navigationBar.backgroundColor = .systemGray6
        searchNC.view.backgroundColor = .systemGray6
        searchNC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        navController.navigationBar.prefersLargeTitles = true
        //navController.navigationBar.barTintColor = .systemGray6
        return navController
    }
    
    func createAppsNC() -> UINavigationController {
        let appsVC = AppsVC()
        let navController = UINavigationController(rootViewController: appsVC)
        
        appsVC.title = "Apps"
        navController.navigationBar.backgroundColor = .systemGray6
        appsVC.view.backgroundColor = .systemGray6
        appsVC.tabBarItem = UITabBarItem(title: "apps", image: UIImage(named: "apps"), tag: 1)
        
        navController.navigationBar.prefersLargeTitles = true
        //navController.navigationBar.barTintColor = .systemGray6
        return navController
    }
    
    func creatTodayNC() -> UINavigationController {
        let todayVC = TodayVC(collectionViewLayout: UICollectionViewFlowLayout())
        let navController = UINavigationController(rootViewController: todayVC)
        
        todayVC.title = "Today"
        navController.navigationBar.isHidden = true
        navController.navigationBar.backgroundColor = .white
        todayVC.view.backgroundColor = .systemGray6
        todayVC.tabBarItem = UITabBarItem(title: "today", image: UIImage(named: "today"), tag: 2)
        
//        navController.navigationBar.prefersLargeTitles = true
        //navController.navigationBar.barTintColor = .systemGray6
        return navController
    }
    
    
    func creatTabBarContoller() -> UITabBarController {
        let tabBAr = UITabBarController()
        UITabBar.appearance().tintColor = .systemRed
        
        tabBAr.viewControllers = [ creatTodayNC() , createAppsNC() , createSearchNC() ]
        
        return tabBAr
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

