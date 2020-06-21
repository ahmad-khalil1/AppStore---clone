//
//  NestedHeaderCollectionView.swift
//  AppStore
//
//  Created by ahmad$$ on 2/28/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit

class NestedHeaderCollectionView: UICollectionReusableView  {

//    let headercollectionView : UICollectionView = {
//        let layout                                = UICollectionViewFlowLayout()
//        layout.scrollDirection                    = .horizontal
//        let collection                       = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout )
//        collection.isScrollEnabled                                 = true
//        collection.translatesAutoresizingMaskIntoConstraints       = false
//
//        return collection
//    }()
    
    
    let collectionView = headercollectionVC(collectionViewLayout: headerFlowLayout())

    
    fileprivate func setUpConstrains() {
        collectionView.view.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.view.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.view.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        collectionView.view.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        addSubview(collectionView.view )
        //backgroundColor = .black
        setUpConstrains()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
