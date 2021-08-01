//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Kirill
// On: 29.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class RSTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        let height: CGFloat = 83.0
//        tabBar.frame.size.height = height
//        tabBar.frame.origin.y = view.frame.height - 83.0
//    }
    
    func setupTabBar() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = .red
    }


}
