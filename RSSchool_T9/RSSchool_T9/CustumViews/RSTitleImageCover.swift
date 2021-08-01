//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Kirill
// On: 1.08.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class RSTitleImageCover: UIImageView {

    let gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.locations = [0.51, 1.0]
        return gradient
    }()
    
    let imageViewGradient: UIView = {
        let gradientView = UIView()
        gradientView.backgroundColor = .clear
        return gradientView
    }()
    
    let textLabel: RSLabelWithInsets = {
        let label = RSLabelWithInsets()
        label.font = UIFont.init(name: "Rockwell-Regular", size: 48.0)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping

        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureView()
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureView() {
        
        layer.cornerRadius = 8.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.white.cgColor
        layer.masksToBounds = true
        contentMode = .scaleAspectFill
        clipsToBounds = true


//        addSubview(titleImageCover)
        imageViewGradient.layer.addSublayer(gradientLayer)
        addSubview(imageViewGradient)
        addSubview(textLabel)

        translatesAutoresizingMaskIntoConstraints = false
        imageViewGradient.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([

            imageViewGradient.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageViewGradient.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageViewGradient.topAnchor.constraint(equalTo: topAnchor),
            imageViewGradient.bottomAnchor.constraint(equalTo: bottomAnchor),

            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30.0),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30.0),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -55.0),
        ])

    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradientLayer.frame = imageViewGradient.bounds
        textLabel.invalidateIntrinsicContentSize()
    }

}


class RSLabelWithInsets: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        super.drawText(in: rect.inset(by: insets))
    }
}
