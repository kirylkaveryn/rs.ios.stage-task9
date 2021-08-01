//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Kirill
// On: 28.07.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit


class RSCollectionVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    let contentVC = RSContentPresentationVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(contentVC)
        
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.tabBarController?.tabBar.isHidden = false
    }
    

    func configureCollectionView() {
        view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        collection.collectionViewLayout = layout
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = .white
        collection.register(RSViewCollectionCell.self, forCellWithReuseIdentifier: "cell")
        collection.allowsSelection = true
        
        self.view.addSubview(collection)
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collection.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            collection.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            collection.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
        ])
    }
    
    // MARK: Collection view setup delegate methods
    // frame
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2 - 28, height: 200)
    }
    // data
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FillingData.data.count
    }
    // cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RSViewCollectionCell
        cell.setWithData(data: FillingData.data[indexPath.item])
        return cell
    }
    // min vertical spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        30.0
    }
    // insets for content
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 40, right: 20)
    }
    
    // action for cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard self.children.count != 0 else {
            print("Error")
            return
        }
        
        view.addSubview(self.contentVC.view)
        contentVC.view.frame = view.bounds
        contentVC.setWithData(data: FillingData.data[indexPath.item])
        
    }
    
    // redraw collction cells frames when orientation changes
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collection.collectionViewLayout.invalidateLayout()
    }


}
