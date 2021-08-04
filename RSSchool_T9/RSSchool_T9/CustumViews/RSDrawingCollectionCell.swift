//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Kiryl Kaveryn
// On: 3.08.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

@objc public extension UICollectionViewCell {
    @objc func startAnimation() {}
}

class RSDrawingCollectionCell: UICollectionViewCell {

    private let imageView = CAShapeLayer()
    
    private let animation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 4.0
        return animation
    }()

    func set(Image path: CGPath, andColor color: UIColor) {
        imageView.path = path
        imageView.strokeColor = color.cgColor
        imageView.lineWidth = 1
        imageView.fillColor = nil
    
        layer.addSublayer(imageView)
    }
    
    override func startAnimation() {
        imageView.removeAllAnimations()
        imageView.add(animation, forKey: "strokeEnd")
    }

}



