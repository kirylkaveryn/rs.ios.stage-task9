//
// 📰 🐸
// Project: RSSchool_T9
//
// Author: Kiryl Kaveryn
// On: 30.07.21
//
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class RSContentPresentationVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    let imageVC = RSImageVC()
    var drawingActivate = true
    var drawingColor = UIColor()
    let storyContent = RSTextLabel()
    let contentView = UIView()
    let scrollView = UIScrollView()
    let titleImageCover = RSTitleImageCover(frame: .zero)
    let itemTypeLabel = RSContentTypeLabel()

    lazy var story: Story = {
        var story: Story?
        return story!
    }()
    
    lazy var gallery: Gallery = {
        var gallery: Gallery?
        return gallery!
    }()
    
    let closeButton: RSCloseButton = {
        let closeButton = RSCloseButton()
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return closeButton
    }()
    
    let divideLine: UIView = {
        let divideLine = UIView()
        divideLine.layer.borderWidth = 1.0
        divideLine.layer.borderColor = UIColor.white.cgColor
        return divideLine
    }()

    var imageGalleryCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        collection.collectionViewLayout = layout
        collection.backgroundColor = .black
        collection.register(RSImageCollectionCell.self, forCellWithReuseIdentifier: "imageCell")
        collection.allowsSelection = true
        collection.isScrollEnabled = false

        return collection
    }()
    
    var drawGalleryCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        collection.collectionViewLayout = layout
        collection.backgroundColor = .clear
        collection.register(RSDrawingCollectionCell.self, forCellWithReuseIdentifier: "drawingCell")
        collection.allowsSelection = true
        collection.isScrollEnabled = true

        return collection
    }()
    
    let drawingView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        view.backgroundColor = .blue
        return view
    }()
    
    let drawingViewCell: UICollectionViewCell = {
       let cell = UICollectionViewCell()
        cell.backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        cell.backgroundColor = .blue
        return cell
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeForSwitchDrawingButtonNotifications()
        configureMainView()
        addChild(imageVC)
        activateMainViewConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        // hide parent tab bar
        self.tabBarController?.tabBar.isHidden = true

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // show parent tab bar
        self.tabBarController?.tabBar.isHidden = false
    }


    func configureMainView() {
        view.backgroundColor = .black
        // default color
        drawingColor = UIColor(red: 0.953, green: 0.686, blue: 0.133, alpha: 1)
        
        contentView.addSubview(titleImageCover)
        contentView.addSubview(itemTypeLabel)
        contentView.addSubview(divideLine)
        contentView.addSubview(closeButton)

        imageGalleryCollection.delegate = self
        imageGalleryCollection.dataSource = self
        
        drawGalleryCollection.delegate = self
        drawGalleryCollection.dataSource = self
        
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
        imageGalleryCollection.translatesAutoresizingMaskIntoConstraints = false
        drawGalleryCollection.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false

    }

    func setWithData(data: ContentType?) {
        guard let contentData = data else { return }

        switch contentData {
        case .gallery(let gallery):
            self.gallery = gallery
            imageGalleryCollection.reloadData()
            
            titleImageCover.image = gallery.coverImage
            titleImageCover.setText(text: gallery.title)
            itemTypeLabel.text = gallery.type

            storyContent.removeFromSuperview()
            drawGalleryCollection.removeFromSuperview()
            
            contentView.addSubview(imageGalleryCollection)

            activateGalleryConstriants()

        case .story(let story):
            self.story = story
            drawGalleryCollection.reloadData()
            titleImageCover.image = story.coverImage
            titleImageCover.setText(text: story.title)

            itemTypeLabel.text = story.type
            storyContent.text = story.text

            imageGalleryCollection.removeFromSuperview()
            
            contentView.addSubview(drawGalleryCollection)
            contentView.addSubview(storyContent)

            activateStoryConstriants()
            }
    }
    
    func activateMainViewConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 20),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -20),
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),

            titleImageCover.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleImageCover.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleImageCover.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),

            closeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            closeButton.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 30),

            itemTypeLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            itemTypeLabel.centerYAnchor.constraint(equalTo: titleImageCover.bottomAnchor),
            itemTypeLabel.heightAnchor.constraint(equalToConstant: 40),

            divideLine.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            divideLine.centerYAnchor.constraint(equalTo: itemTypeLabel.bottomAnchor, constant: 39),
            divideLine.heightAnchor.constraint(equalToConstant: 1),
            divideLine.widthAnchor.constraint(equalToConstant: 214),

        ])
        
        // recalculate widts and set a height to titleImageCover with saving image ratio (1.338)
        view.layoutIfNeeded()
        NSLayoutConstraint.activate([
            titleImageCover.heightAnchor.constraint(equalToConstant: titleImageCover.frame.width * 1.338),
        ])
    }
    
    func activateStoryConstriants() {
        NSLayoutConstraint.activate([
            drawGalleryCollection.heightAnchor.constraint(equalToConstant: 100),
            drawGalleryCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            drawGalleryCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            drawGalleryCollection.topAnchor.constraint(equalTo: titleImageCover.bottomAnchor, constant: 98),
            
            storyContent.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            storyContent.topAnchor.constraint(equalTo: titleImageCover.bottomAnchor, constant: 238),
            storyContent.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    func activateGalleryConstriants() {
        // деактивируем старые констрэйнты
        NSLayoutConstraint.deactivate(imageGalleryCollection.constraints)
        // констрэйнты ширины
        NSLayoutConstraint.activate([
            imageGalleryCollection.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageGalleryCollection.topAnchor.constraint(equalTo: titleImageCover.bottomAnchor, constant: 98),
        ])
//        print("imageGalleryCollection.intrinsicContentSize", imageGalleryCollection.intrinsicContentSize)
//        print("imageGalleryCollection.contentSize", imageGalleryCollection.contentSize)
        // пересчет contentSize для уже установленных констрэйнтов (ширины) и автоматом вычисляется высота необходимая для размещения коллекшн вью
//        print("view.layoutIfNeeded()")
        view.layoutIfNeeded()
//        print("imageGalleryCollection.intrinsicContentSize", imageGalleryCollection.intrinsicContentSize)
//        print("imageGalleryCollection.contentSize", imageGalleryCollection.contentSize)
        // констрэйнты высоты
        NSLayoutConstraint.activate([
            imageGalleryCollection.heightAnchor.constraint(equalToConstant: imageGalleryCollection.contentSize.height),
            imageGalleryCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    // close VC
    @objc func closeButtonTapped() {
        self.view.removeFromSuperview()
    }

    // MARK: Collection view setup delegate methods
    // frame
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case imageGalleryCollection:
            return CGSize(width: imageGalleryCollection.frame.size.width, height: 510)
        case drawGalleryCollection:
            return CGSize(width: 75, height: 75)
        default:
            return CGSize.zero
        }
    }

    // numbers of items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case imageGalleryCollection:
            return gallery.images.count
        case drawGalleryCollection:
            return story.paths.count
        default:
            return 0
        }
    }
    
    // create cells with data
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case imageGalleryCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! RSImageCollectionCell
            cell.setWithData(data: gallery.images[indexPath.item])
            return cell
            
        case drawGalleryCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "drawingCell", for: indexPath) as! RSDrawingCollectionCell
            cell.set(Image: story.paths[indexPath.item], andColor: drawingColor)

            return cell
        default:
            return UICollectionViewCell()
        }
    }

    // min vertical spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case imageGalleryCollection:
            return 20
        case drawGalleryCollection:
            return 100
        default:
            return 0
        }
    }

    // insets for content
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case imageGalleryCollection:
            return UIEdgeInsets.zero
        case drawGalleryCollection:
            return UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)
        default:
            return UIEdgeInsets.zero
        }
    }

    // action for cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case imageGalleryCollection:
            imageVC.setImage(withImage: gallery.images[indexPath.item])
            imageVC.view.frame = view.bounds
            view.addSubview(imageVC.view)
        case drawGalleryCollection:
            break
        default:
            break
        }
    }
    
    // set animation when drawings displayed
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch collectionView {
        case imageGalleryCollection:
            break
        case drawGalleryCollection:
            if drawingActivate == true {
                cell.startAnimation()
            }
        default:
            break
        }
    }

    //  redraw collction cells frames when orientation changes
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        contentView.invalidateIntrinsicContentSize()
        scrollView.invalidateIntrinsicContentSize()
        imageGalleryCollection.collectionViewLayout.invalidateLayout()
        drawGalleryCollection.collectionViewLayout.invalidateLayout()
    }
    
    // subscribe for notification from switch
    func subscribeForSwitchDrawingButtonNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(switchButtonIsOn(notification:)), name: NSNotification.Name(rawValue: "SwitchButtonIsOn"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(switchButtonIsOff(notification:)), name: NSNotification.Name(rawValue: "SwitchButtonIsOff"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setColorForDrawing(notification:)), name: NSNotification.Name(rawValue: "SetColorForDrawing"), object: nil)
    }
    
    @objc func switchButtonIsOn(notification: Notification) {
        drawingActivate = true
    }
    @objc func switchButtonIsOff(notification: Notification) {
        drawingActivate = false
    }
    @objc func setColorForDrawing(notification: Notification) {
        if let color = notification.userInfo?["Color"] as? UIColor {
            drawingColor = color
        }
    }
}


//
////
//// 📰 🐸
//// Project: RSSchool_T9
////
//// Author: Kiryl Kaveryn
//// On: 30.07.21
////
//// Copyright © 2021 RSSchool. All rights reserved.
//
//import UIKit
//
//class RSContentPresentationVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
//
//    let imageVC = RSImageVC()
//
//    var drawingActivate = true
//    var drawingColor = UIColor()
//
//    lazy var story: Story = {
//        var story: Story?
//        return story!
//    }()
//
//    lazy var gallery: Gallery = {
//        var gallery: Gallery?
//        return gallery!
//    }()
//
//    let storyContent = RSTextLabel()
//
//    let closeButton: RSCloseButton = {
//        let closeButton = RSCloseButton()
//        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
//        return closeButton
//    }()
//
//    let contentView = UIView()
//    let scrollView = UIScrollView()
//    let titleImageCover = RSTitleImageCover(frame: .zero)
//    let itemTypeLabel = RSContentTypeLabel()
//    let divideLine: UIView = {
//        let divideLine = UIView()
//        divideLine.layer.borderWidth = 1.0
//        divideLine.layer.borderColor = UIColor.white.cgColor
//        return divideLine
//    }()
//
//    var imageGalleryCollection: UICollectionView = {
//        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//
//        collection.collectionViewLayout = layout
//        collection.backgroundColor = .black
//        collection.register(RSImageCollectionCell.self, forCellWithReuseIdentifier: "imageCell")
//        collection.allowsSelection = true
//        collection.isScrollEnabled = false
//
//        return collection
//    }()
//
//    var drawGalleryCollection: UICollectionView = {
//        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//
//        collection.collectionViewLayout = layout
//        collection.backgroundColor = .clear
//        collection.register(RSDrawingCollectionCell.self, forCellWithReuseIdentifier: "drawingCell")
//        collection.allowsSelection = true
//        collection.isScrollEnabled = true
//
//        return collection
//    }()
//
//    let drawingView: UIView = {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
//        view.backgroundColor = .blue
//        return view
//    }()
//
//    let drawingViewCell: UICollectionViewCell = {
//       let cell = UICollectionViewCell()
//        cell.backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
//        cell.backgroundColor = .blue
//        return cell
//    }()
//
//    lazy var galleryCollectionHeight = CGFloat()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        subscribeForSwitchDrawingButtonNotifications()
//        configureMainView()
//        addChild(imageVC)
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        // hide parent tab bar
//        self.tabBarController?.tabBar.isHidden = true
//
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        // show parent tab bar
//        self.tabBarController?.tabBar.isHidden = false
//    }
//
//
//    func configureMainView() {
//        view.backgroundColor = .black
//        // default color
//        drawingColor = UIColor(red: 0.953, green: 0.686, blue: 0.133, alpha: 1)
//
//        contentView.addSubview(titleImageCover)
//        contentView.addSubview(itemTypeLabel)
//        contentView.addSubview(divideLine)
//        contentView.addSubview(closeButton)
//
//        imageGalleryCollection.delegate = self
//        imageGalleryCollection.dataSource = self
//
//        drawGalleryCollection.delegate = self
//        drawGalleryCollection.dataSource = self
//
//        scrollView.addSubview(contentView)
//        scrollView.frame = view.bounds
//        scrollView.delaysContentTouches = false
//
//        view.addSubview(scrollView)
//
//        titleImageCover.translatesAutoresizingMaskIntoConstraints = false
//        itemTypeLabel.translatesAutoresizingMaskIntoConstraints = false
//        divideLine.translatesAutoresizingMaskIntoConstraints = false
//        storyContent.translatesAutoresizingMaskIntoConstraints = false
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//        closeButton.translatesAutoresizingMaskIntoConstraints = false
//        imageGalleryCollection.translatesAutoresizingMaskIntoConstraints = false
//        drawGalleryCollection.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//
//    }
//
//    func setWithData(data: ContentType?) {
//        guard let contentData = data else { return }
//
//        switch contentData {
//        case .gallery(let gallery):
//            self.gallery = gallery
//            imageGalleryCollection.reloadData()
//            // FIXME: (костыльный костыль определения высоты коллекшена - исправить на autolayout!!!)
//            galleryCollectionHeight = (CGFloat)(gallery.images.count * 530)
//
//            titleImageCover.image = gallery.coverImage
//            titleImageCover.setText(text: gallery.title)
//            itemTypeLabel.text = gallery.type
//
//            storyContent.removeFromSuperview()
//            drawGalleryCollection.removeFromSuperview()
//            contentView.addSubview(imageGalleryCollection)
//
//            activateMainViewConstraints()
//            activateGalleryConstriants()
//
//        case .story(let story):
//            self.story = story
//            drawGalleryCollection.reloadData()
//            titleImageCover.image = story.coverImage
//            titleImageCover.setText(text: story.title)
//
//            itemTypeLabel.text = story.type
//            storyContent.text = story.text
//
//            imageGalleryCollection.removeFromSuperview()
//
//            contentView.addSubview(drawGalleryCollection)
//            contentView.addSubview(storyContent)
//
//            activateMainViewConstraints()
//            activateStoryConstriants()
//            }
//    }
//
//    func activateMainViewConstraints() {
//        NSLayoutConstraint.activate([
//            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//
//            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
//
//            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 20),
//            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -20),
//            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
//            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
//
//            titleImageCover.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            titleImageCover.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            titleImageCover.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
//
//            closeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
//            closeButton.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 30),
//
//            itemTypeLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
//            itemTypeLabel.centerYAnchor.constraint(equalTo: titleImageCover.bottomAnchor),
//            itemTypeLabel.heightAnchor.constraint(equalToConstant: 40),
//
//            divideLine.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            divideLine.centerYAnchor.constraint(equalTo: itemTypeLabel.bottomAnchor, constant: 39),
//            divideLine.heightAnchor.constraint(equalToConstant: 1),
//            divideLine.widthAnchor.constraint(equalToConstant: 214),
//
//        ])
//
//
//        // recalculate widts and set a height to titleImageCover with saving image ratio (1.338)
//        view.layoutIfNeeded()
//        NSLayoutConstraint.activate([
//            titleImageCover.heightAnchor.constraint(equalToConstant: titleImageCover.frame.width * 1.338),
//        ])
//    }
//
//    func activateStoryConstriants() {
//        NSLayoutConstraint.activate([
//
//            drawGalleryCollection.heightAnchor.constraint(equalToConstant: 100),
//            drawGalleryCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            drawGalleryCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            drawGalleryCollection.topAnchor.constraint(equalTo: titleImageCover.bottomAnchor, constant: 98),
//
//            storyContent.widthAnchor.constraint(equalTo: contentView.widthAnchor),
//            storyContent.topAnchor.constraint(equalTo: titleImageCover.bottomAnchor, constant: 238),
//            storyContent.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//        ])
//    }
//
//    func activateGalleryConstriants() {
//        // деактивируем старые констрэйнты
//        NSLayoutConstraint.deactivate(imageGalleryCollection.constraints)
//        // констрэйнты ширины
//        NSLayoutConstraint.activate([
//            imageGalleryCollection.widthAnchor.constraint(equalTo: contentView.widthAnchor),
//            imageGalleryCollection.topAnchor.constraint(equalTo: titleImageCover.bottomAnchor, constant: 98),
//        ])
//
//        print("imageGalleryCollection.intrinsicContentSize", imageGalleryCollection.intrinsicContentSize)
//        print("imageGalleryCollection.contentSize", imageGalleryCollection.contentSize)
//        // пересчет contentSize для уже установленных констрэйнтов (ширины) и автоматом вычисляется высота необходимая для размещения коллекшн вью
//        print("view.layoutIfNeeded()")
//        view.layoutIfNeeded()
//        print("imageGalleryCollection.intrinsicContentSize", imageGalleryCollection.intrinsicContentSize)
//        print("imageGalleryCollection.contentSize", imageGalleryCollection.contentSize)
//
//        // констрэйнты высоты
//        NSLayoutConstraint.activate([
//            imageGalleryCollection.heightAnchor.constraint(equalToConstant: imageGalleryCollection.contentSize.height),
//            imageGalleryCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//
//        ])
//
//
//
//    }
//
//
//    // close VC
//    @objc func closeButtonTapped() {
//        self.view.removeFromSuperview()
//    }
//
//    // MARK: Collection view setup delegate methods
//    // frame
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        switch collectionView {
//        case imageGalleryCollection:
//            return CGSize(width: imageGalleryCollection.frame.size.width, height: 510)
//        case drawGalleryCollection:
//            return CGSize(width: 75, height: 75)
//        default:
//            return CGSize.zero
//        }
//    }
//
//    // numbers of items
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch collectionView {
//        case imageGalleryCollection:
//            return gallery.images.count
//        case drawGalleryCollection:
//            return story.paths.count
//        default:
//            return 0
//        }
//    }
//
//    // create cells with data
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        switch collectionView {
//        case imageGalleryCollection:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! RSImageCollectionCell
//            cell.setWithData(data: gallery.images[indexPath.item])
//            return cell
//
//        case drawGalleryCollection:
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "drawingCell", for: indexPath) as! RSDrawingCollectionCell
//            cell.set(Image: story.paths[indexPath.item], andColor: drawingColor)
//
//            return cell
//        default:
//            return UICollectionViewCell()
//        }
//    }
//
//    // min vertical spacing
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        switch collectionView {
//        case imageGalleryCollection:
//            return 20
//        case drawGalleryCollection:
//            return 100
//        default:
//            return 0
//        }
//    }
//
//    // insets for content
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        switch collectionView {
//        case imageGalleryCollection:
//            return UIEdgeInsets.zero
//        case drawGalleryCollection:
//            return UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)
//        default:
//            return UIEdgeInsets.zero
//        }
//    }
//
//    // action for cell
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        switch collectionView {
//        case imageGalleryCollection:
//            imageVC.setImage(withImage: gallery.images[indexPath.item])
//            imageVC.view.frame = view.bounds
//            view.addSubview(imageVC.view)
//        case drawGalleryCollection:
//            break
//        default:
//            break
//        }
//    }
//
//    // set animation and color when drawings displayed
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        switch collectionView {
//        case imageGalleryCollection:
//            break
//        case drawGalleryCollection:
//            if drawingActivate == true {
//                cell.startAnimation()
//            }
//        default:
//            break
//        }
//    }
//
//    //  redraw collction cells frames when orientation changes
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//        contentView.invalidateIntrinsicContentSize()
//        scrollView.invalidateIntrinsicContentSize()
//        imageGalleryCollection.collectionViewLayout.invalidateLayout()
//        drawGalleryCollection.collectionViewLayout.invalidateLayout()
//    }
//
//    func subscribeForSwitchDrawingButtonNotifications() {
//        NotificationCenter.default.addObserver(self, selector: #selector(switchButtonIsOn(notification:)), name: NSNotification.Name(rawValue: "SwitchButtonIsOn"), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(switchButtonIsOff(notification:)), name: NSNotification.Name(rawValue: "SwitchButtonIsOff"), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(setColorForDrawing(notification:)), name: NSNotification.Name(rawValue: "SetColorForDrawing"), object: nil)
//    }
//
//    @objc func switchButtonIsOn(notification: Notification) {
//        drawingActivate = true
////        print("switchButtonIsOn")
//    }
//    @objc func switchButtonIsOff(notification: Notification) {
//        drawingActivate = false
////        print("switchButtonIsOff")
//    }
//    @objc func setColorForDrawing(notification: Notification) {
//        if let color = notification.userInfo?["Color"] as? UIColor {
//            drawingColor = color
//        }
//    }
//
//}
//
//
//
