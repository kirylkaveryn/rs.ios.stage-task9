//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Kiryl Kaveryn
// On: 29.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class RSTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    func setupTabBar() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .red
    }

}
