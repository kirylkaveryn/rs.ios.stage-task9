//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Kiryl Kaveryn
// On: 1.08.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class RSImageCollectionCell: UICollectionViewCell {
    
    let image: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 4.0
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setWithData(data: UIImage) {
        image.image = data
    }
    
    func configureView() {
        
        layer.backgroundColor = UIColor.clear.cgColor
        layer.cornerRadius = 8.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.white.cgColor
    
        addSubview(image)

        translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0),
            image.topAnchor.constraint(equalTo: topAnchor, constant: 10.0),
            image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0),
        ])
    }
}
