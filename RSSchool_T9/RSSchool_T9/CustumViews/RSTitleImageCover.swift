//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Kiryl Kaveryn
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
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "Rockwell-Regular", size: 48.0)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
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
    }
    
    func setText(text: String) {
        let baseText = String(text.trimmingCharacters(in: NSCharacterSet.newlines))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.1
        textLabel.attributedText = NSMutableAttributedString(string: baseText, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])

    }

}

