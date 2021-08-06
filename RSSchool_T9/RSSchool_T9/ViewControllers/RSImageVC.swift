//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Kiryl Kaveryn
// On: 2.08.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class RSImageVC: UIViewController, UIScrollViewDelegate {
    
    var image = UIImage()
    var imageView = UIImageView()
    
    let scrollView = UIScrollView()
    let closeButton: RSCloseButton = {
        let closeButton = RSCloseButton()
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return closeButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        scrollView.zoomScale = 1
        constriantsActivate()
    }
    
    func configureView() {
        view.backgroundColor = .black
        
        imageView.contentMode = .scaleAspectFit
        
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 3
        scrollView.delegate = self
        scrollView.addSubview(imageView)
        
        view.addSubview(scrollView)
        view.addSubview(closeButton)
        
        // add gesture recognizer to zoom out by double tap
        let gestureDoubleTap = UITapGestureRecognizer()
        gestureDoubleTap.numberOfTapsRequired = 2
        gestureDoubleTap.addTarget(self, action: #selector(doubleTapToDefaultZoom))
        scrollView.addGestureRecognizer(gestureDoubleTap)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func doubleTapToDefaultZoom() {
        scrollView.setZoomScale(1.0, animated: true)
    }
    
    func constriantsActivate() {
        NSLayoutConstraint.activate([
            scrollView.frameLayoutGuide.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.frameLayoutGuide.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.frameLayoutGuide.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.frameLayoutGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            scrollView.contentLayoutGuide.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
            scrollView.contentLayoutGuide.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
            scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: scrollView.frameLayoutGuide.topAnchor),
            scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: scrollView.frameLayoutGuide.bottomAnchor),
            
            imageView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),

            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25),
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
        ])
    }
    
    // set image to VC (called in RSContentPresentationVC)
    func setImage(withImage image: UIImage) {
        self.image = image
        self.imageView.image = self.image
    }
    
    // add zooming
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return scrollView.subviews.first
    }
    
    // close VC
    @objc func closeButtonTapped() {
        self.view.removeFromSuperview()
    }
    
    // redraw collction cells frames when orientation changes
    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        scrollView.invalidateIntrinsicContentSize()
    }

}
