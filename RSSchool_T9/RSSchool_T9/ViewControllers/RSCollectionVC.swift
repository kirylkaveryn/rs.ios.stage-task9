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
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .white
        
        configureCollectionView()

        
    }
    

    func configureCollectionView() {
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
            collection.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0),
            collection.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0),
            collection.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0),
            collection.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0.0),
        ])
    }
    
    // MARK: Collection view setup delegate methods
    // frame
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2 - 8 - 20, height: 200)
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
        return UIEdgeInsets(top: 40, left: 20, bottom: 20, right: 20)
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

    }


}