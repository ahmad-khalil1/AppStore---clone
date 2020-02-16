//
//  AppSearchVC.swift
//  AppStore
//
//  Created by ahmad$$ on 2/14/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit


class AppSearchVC: UIViewController{
    var searchAbleItems = ["FIrst", "Second"]
    let cellId = "cellid"
    
    //MARK:- UI CollectionView Configration
    
    let collectionView : UICollectionView = {

        let layout = ColumnFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        
        collection.backgroundColor = UIColor.darkGray
        collection.isScrollEnabled = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        return collection
    }()
    
    func setupCollectionViewCOnstrains(){
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        
        collectionView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true

    }
    
    
    //MARK:- viewDidLoad Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CustomViewCell.self, forCellWithReuseIdentifier: cellId)

        view.addSubview(collectionView)
        setupCollectionViewCOnstrains()
    }
    
}
    //MARK:- collectionView DataSource Methods


extension AppSearchVC : UICollectionViewDataSource , UICollectionViewDelegate  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .systemBlue
        return cell
    }
    
    
}

    
    
    
    


