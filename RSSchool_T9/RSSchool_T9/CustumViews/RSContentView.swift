//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Kiryl Kaveryn
// On: 31.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class RSContentView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 8.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.masksToBounds = true
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawText(in rect: CGRect) {}
    
}
