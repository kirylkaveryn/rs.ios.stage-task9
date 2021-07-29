//
// 📰 🐸
// Project: RSSchool_T9
//
// Author: Uladzislau Volchyk
// On: 23.07.21
//
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else {
            fatalError("LOL, be careful, drink some water")
        }
        
        let vc1 = UIViewController()
        vc1.view.backgroundColor = .red
        let vc2 = UIViewController()
        vc2.view.backgroundColor = .green

        vc1.title = "one"
        vc2.title = "two"
        
        
        let rootController = RSTabBarController()
        let collectionController = RSCollectionVC()
        let settingsController = UINavigationController(rootViewController: RSSettingsVC())
        rootController.setViewControllers([collectionController, settingsController], animated: false)
        
        
        guard let items = rootController.tabBar.items else {
            return
        }

        let image0 = UIImage(systemName: "square.grid.2x2")
        let image1 = UIImage(systemName: "gear")
        items[0].image = image0
        items[0].title = "Items"
        items[1].image = image1
        items[1].title = "Settings"
        
//        rootController.tabBar.setItems([UITabBarItem(title: "Image", image: image0, tag: 0),
//                                        UITabBarItem(title: "Settings", image: image1, tag: 1)], animated: false)
        
        window = UIWindow.init(windowScene: windowScene)
        window?.rootViewController = rootController
        window?.makeKeyAndVisible()
        
    }
    
}



