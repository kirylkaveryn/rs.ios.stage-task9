//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Kiryl Kaveryn
// On: 31.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class RSContentTypeLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.backgroundColor = UIColor.black.cgColor
        self.layer.cornerRadius = 8.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        self.font = UIFont.init(name: "Rockwell", size: 24.0)
        self.textAlignment = .center
        self.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + 60, height: size.height)
    }

}
