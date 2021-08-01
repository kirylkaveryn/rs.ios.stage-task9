//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Kirill
// On: 31.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class RSCloseButton: UIButton {
    
    let xmark = UIImageView.init(image: UIImage(systemName: "xmark"))

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let radius: CGFloat = 20
        
        self.frame = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
        self.layer.cornerRadius = radius
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1.0
        self.clipsToBounds = true
        
        xmark.tintColor = .white
        
        self.addSubview(xmark)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        xmark.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: radius * 2),
            self.widthAnchor.constraint(equalToConstant: radius * 2),
            xmark.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            xmark.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isHighlighted: Bool {
        didSet {
            xmark.tintColor = isHighlighted ? UIColor(red: 0.475, green: 0.475, blue: 0.475, alpha: 1) : .white
        }
    }
    
}
