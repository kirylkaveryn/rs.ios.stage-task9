//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Kirill
// On: 29.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class RSTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        print(tabBar.frame.size.height)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let height: CGFloat = 83.0
        tabBar.frame.size.height = height
        tabBar.frame.origin.y = view.frame.height - 83.0
    }
    
    func setupTabBar() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .red
        
        
//
//        let image1 = UITabBarItem()
//        image1.image = UIImage(systemName: "star")
//
//        self.tabBar.setItems([image1,image1,image1], animated: false)
    }


}
