//
//  AppsVC.swift
//  AppStore
//
//  Created by ahmad$$ on 2/26/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit

class AppsVC: UIViewController {

    let cellId = "cell"
    let supplemantryId = "supp"
      let collectionView : UICollectionView = {
          
          let layout = AppsColumnFlowLayout()
          layout.scrollDirection                                     = .vertical
          let collection                                             = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
          
          collection.backgroundColor                                 = .white
          collection.isScrollEnabled                                 = true
          collection.translatesAutoresizingMaskIntoConstraints       = false
          
          return collection
      }()
    
    func setupCollectionViewCOnstrains(){
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive         = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive   = true
        collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive       = true
        collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive     = true
        
        collectionView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive   = true
        collectionView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive     = true
        
       }
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.register(appsCustomViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(NestedHeaderCollectionView.self
            , forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: supplemantryId)

        view.addSubview(collectionView)
        setupCollectionViewCOnstrains()
        
    }
    

    
}

extension AppsVC : UICollectionViewDataSource , UICollectionViewDelegate  {
    
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
       // cell.backgroundColor = .blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let suppView = collectionView.dequeueReusableSupplementaryView(ofKind:
            kind, withReuseIdentifier: supplemantryId, for: indexPath)
        //suppView.frame.size.height  = 250
        return suppView
    }
}
