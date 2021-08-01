//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Kirill
// On: 30.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class RSContentPresentationVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {


    var story: Story?
    var gallery: Gallery?
    let storyContent = RSTextLabel()
    let closeButton = RSCloseButton()
    let contentView = UIView()
    let scrollView = UIScrollView()
    
    let titleImageCover = RSTitleImageCover(frame: .zero)

    
    
//    let titleImageCover: UIImageView = {
//        let image = UIImageView()
//        image.layer.cornerRadius = 8.0
//        image.layer.borderWidth = 1.0
//        image.layer.borderColor = UIColor.white.cgColor
//        image.layer.masksToBounds = true
//        image.contentMode = .scaleAspectFill
//        image.clipsToBounds = true
//        return image
//    }()
//
//    let gradientLayer: CAGradientLayer = {
//        let gradient = CAGradientLayer()
//        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
//        gradient.startPoint = CGPoint.zero
//        gradient.endPoint = CGPoint(x: 0, y: 1)
//        gradient.locations = [0.51, 1.0]
//        return gradient
//    }()
//
//    let imageViewGradient: UIView = {
//        let gradientView = UIView()
//        gradientView.backgroundColor = .clear
//        return gradientView
//    }()
    
//    let textLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.init(name: "Rockwell-Regular", size: 48.0)
//        label.textColor = .white
//        label.textAlignment = .left
//        label.numberOfLines = 0
//        label.lineBreakMode = .byWordWrapping
//        return label
//    }()
    
    let itemTypeLabel = RSContentTypeLabel()
    
    let divideLine: UIView = {
        let divideLine = UIView()
        divideLine.layer.borderWidth = 1.0
        divideLine.layer.borderColor = UIColor.white.cgColor
        return divideLine
    }()
    
    var galleryCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        collection.collectionViewLayout = layout
        collection.backgroundColor = .black
        collection.register(RSImageCollectionCell.self, forCellWithReuseIdentifier: "cell")
        collection.allowsSelection = true
        collection.isScrollEnabled = false
        
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainView()
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        print("viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // hide parent tab bar
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func configureMainView() {
        view.backgroundColor = .black
        
//        titleImageCover.layer.addSublayer(gradientLayer)
//        gradientLayer.frame = titleImageCover.bounds
//        titleImageCover.addSubview(textLabel)

        contentView.addSubview(titleImageCover)
        contentView.addSubview(itemTypeLabel)
        contentView.addSubview(divideLine)
        contentView.addSubview(closeButton)
        
        galleryCollection.delegate = self
        galleryCollection.dataSource = self

        scrollView.addSubview(contentView)
        scrollView.frame = view.bounds
        scrollView.delaysContentTouches = false

        view.addSubview(scrollView)
        
        titleImageCover.translatesAutoresizingMaskIntoConstraints = false
        itemTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        divideLine.translatesAutoresizingMaskIntoConstraints = false
        storyContent.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        galleryCollection.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func activateMainViewConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            
            titleImageCover.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleImageCover.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            titleImageCover.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            titleImageCover.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 70),
            titleImageCover.heightAnchor.constraint(equalToConstant: 500),
            
            closeButton.trailingAnchor.constraint(equalTo: titleImageCover.trailingAnchor),
            closeButton.topAnchor.constraint(equalTo: scrollView.topAnchor),

            itemTypeLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            itemTypeLabel.centerYAnchor.constraint(equalTo: titleImageCover.bottomAnchor),
            itemTypeLabel.heightAnchor.constraint(equalToConstant: 40),
            itemTypeLabel.widthAnchor.constraint(equalToConstant: itemTypeLabel.intrinsicContentSize.width + 60),

            divideLine.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            divideLine.centerYAnchor.constraint(equalTo: itemTypeLabel.bottomAnchor, constant: 39),
            divideLine.heightAnchor.constraint(equalToConstant: 1),
            divideLine.widthAnchor.constraint(equalToConstant: 214),

        ])

    }
    
    func activateStoryConstriants() {
        
        NSLayoutConstraint.activate([
            storyContent.leadingAnchor.constraint(equalTo: titleImageCover.leadingAnchor),
            storyContent.trailingAnchor.constraint(equalTo: titleImageCover.trailingAnchor),
            storyContent.topAnchor.constraint(equalTo: titleImageCover.bottomAnchor, constant: 219),
            storyContent.heightAnchor.constraint(greaterThanOrEqualToConstant: 0),
            
            scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: storyContent.bottomAnchor),
        ])
        
    }
    
    func activateGalleryConstriants() {
        
        NSLayoutConstraint.activate([
            galleryCollection.leadingAnchor.constraint(equalTo: titleImageCover.leadingAnchor),
            galleryCollection.trailingAnchor.constraint(equalTo: titleImageCover.trailingAnchor),
            galleryCollection.topAnchor.constraint(equalTo: titleImageCover.bottomAnchor, constant: 98),
            galleryCollection.heightAnchor.constraint(equalToConstant: (CGFloat)((gallery?.images.count)! * 530)),
            
            scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: galleryCollection.bottomAnchor),
        ])
//        print(galleryCollection.frame)
        
    }
    
    
    func setWithData(data: ContentType?) {
        guard let data = data else { return }
        
        switch data {
        case .gallery(let gallery):
            self.gallery = nil
            self.gallery = gallery
            galleryCollection.reloadData()
            titleImageCover.image = gallery.coverImage
            titleImageCover.textLabel.text = gallery.title
            itemTypeLabel.text = gallery.type
            
            storyContent.removeFromSuperview()
            contentView.addSubview(galleryCollection)
            activateMainViewConstraints()
            activateGalleryConstriants()
            
            
        case .story(let story):
            
            self.story = story
            titleImageCover.image = story.coverImage
            titleImageCover.textLabel.text = story.title

            itemTypeLabel.text = story.type
            storyContent.text = story.text
            
            galleryCollection.removeFromSuperview()
            contentView.addSubview(storyContent)
            activateMainViewConstraints()
            activateStoryConstriants()
            }
    }
    
    // close VC
    @objc func closeButtonTapped() {
        self.view.removeFromSuperview()
    }
    
    // MARK: Collection view setup delegate methods
    // frame
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: galleryCollection.frame.size.width, height: 510)
    }
    
    // numbers of items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (gallery?.images.count)!
    }
    
    // cell data
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RSImageCollectionCell
        cell.setWithData(data: (gallery?.images[indexPath.item])!)
        return cell
    }
    
    // min vertical spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20.0
    }

    // action for cell
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard self.children.count != 0 else {
//            print("Error")
//            return
//        }
//
//        view.addSubview(self.contentVC.view)
//        contentVC.view.frame = view.bounds
//        contentVC.setWithData(data: FillingData.data[indexPath.item])
//
//    }

    // redraw collction cells frames when orientation changes
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        galleryCollection.collectionViewLayout.invalidateLayout()
//    }
    
}

