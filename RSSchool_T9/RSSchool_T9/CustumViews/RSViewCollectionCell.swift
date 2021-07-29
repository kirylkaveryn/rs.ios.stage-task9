//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Kirill
// On: 28.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class RSViewCollectionCell: UICollectionViewCell {
    
    
    let image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let imageView: UIView = {
        let view = UIView()
//        view.backgroundColor = .red
        view.layer.cornerRadius = 10.0
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.masksToBounds = true
        return view
    }()
    
    
    // FIXME: fix gradient
    let imageViewGradient: UIView = {
        let gradient = CAGradientLayer()
        let gradientView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 100))
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.frame = gradientView.frame
        gradient.startPoint = CGPoint.zero
        gradient.endPoint = CGPoint(x: 0, y: 1)
//        gradient.delegate = self()
        gradientView.layer.addSublayer(gradient)
        return gradientView
    }()
    
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "Rockwell", size: 16.0)
        label.textAlignment = .left
        label.textColor = .white
        label.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 700), for: NSLayoutConstraint.Axis.horizontal)
        return label
    }()
    
    let itemTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "Rockwell", size: 12.0)
        label.textAlignment = .left
        label.textColor = UIColor(hue: 0.0, saturation: 0.0, brightness: 0.71, alpha: 1)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureView()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    
    func setWithData(data: ContentType?) {
        guard let data = data else { return }

        switch data {
        case .gallery(let gallery):
            image.image = gallery.coverImage
            textLabel.text = gallery.title
            itemTypeLabel.text = gallery.type
        case .story(let story):
            image.image = story.coverImage
            textLabel.text = story.title
            itemTypeLabel.text = story.type
        }
    }
    
    
    func configureView() {
        
        layer.backgroundColor = UIColor.white.cgColor
        layer.cornerRadius = 18.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.black.cgColor
    
        // FIXME: fix gradient
        addSubview(imageView)
        imageView.addSubview(image)
        imageView.addSubview(imageViewGradient)
        imageView.addSubview(textLabel)
        imageView.addSubview(itemTypeLabel)
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:))))

        translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageViewGradient.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        itemTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            topAnchor.constraint(equalTo: contentView.topAnchor),
            bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -20.0),
            trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
            
            imageView.widthAnchor.constraint(equalTo: widthAnchor, constant: -16.0),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, constant: -20.0),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
//             FIXME: fix gradient
            imageViewGradient.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            imageViewGradient.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            imageViewGradient.topAnchor.constraint(equalTo: imageView.topAnchor),
            imageViewGradient.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),

            image.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            image.heightAnchor.constraint(equalTo: imageView.heightAnchor),
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.centerYAnchor.constraint(equalTo: centerYAnchor),

            textLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 10.0),
            textLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -15.0),
            textLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -30.0),
            textLabel.heightAnchor.constraint(equalToConstant: 19.0),

            itemTypeLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 10.0),
            itemTypeLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15.0),
            itemTypeLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -13.0),
            itemTypeLabel.heightAnchor.constraint(equalToConstant: 14.0),
        ])
        

    }
    
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        imageViewGradient.frame = imageView.bounds
    }
    
    
    @objc func viewTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        print("tap: \(String(describing: textLabel.text))")
    }

}



//class LayerDelegate: NSObject, CALayerDelegate {
//    func layoutSublayers(of layer: CALayer) {
//        super.layoutSublayers(of: layer)
//        layer.frame = autoContent.bounds
//    }
//
//}
