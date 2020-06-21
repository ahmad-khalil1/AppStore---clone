//
//  AppsVC.swift
//  AppStore
//
//  Created by ahmad$$ on 2/26/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit



class AppsVC: UIViewController {
    
    //MARK:- VC Properties and objects.

    var apps                                         = [App]()
    let cellId                                       = "cell"
    let supplemantryId                               = "supp"
    let networkManager                               = NetworkManager()
    var appsGroupArray : [AppGroup]?                 = [AppGroup]()
    
    //MARK:- UI Elements.

    let collectionView : UICollectionView = {
        let layout                                                 = AppsColumnFlowLayout()
        let collection                                             = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        
        layout.scrollDirection                                     = .vertical
        collection.backgroundColor                                 = .white
        collection.isScrollEnabled                                 = true
        collection.translatesAutoresizingMaskIntoConstraints       = false
        
        return collection
    }()
    
    //MARK:- Setting up the UI elemnts Position.

    func setupCollectionViewCOnstrains(){
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive         = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive   = true
        collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive       = true
        collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive     = true
        
        collectionView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive   = true
        collectionView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive     = true   
       }
       
    //MARK:- View Life Cycle.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAppsFeed()
        ConfigureCollectionView()

        view.addSubview(collectionView)
        setupCollectionViewCOnstrains()
        
    }
    
    fileprivate func getAppsFeed() {
         networkManager.getAppsFeed(with: ["new-apps-we-love" , "new-games-we-love" , "top-free"] ) { (appsGroups, error) in
             if let appsGroups = appsGroups {
                 self.appsGroupArray = appsGroups
                 DispatchQueue.main.async {
                     self.collectionView.reloadData()
                 }
             }
         }
     }
    
    fileprivate func ConfigureCollectionView() {
        collectionView.dataSource = self
        collectionView.register(appsCustomViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(NestedHeaderCollectionView.self
            , forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: supplemantryId)
    }
}

//MARK:- collectionView DataSource and Delegate Methods.

extension AppsVC : UICollectionViewDataSource , UICollectionViewDelegate  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = appsGroupArray?.count{
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! appsCustomViewCell
        cell.appCategory = appsGroupArray?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let suppView = collectionView.dequeueReusableSupplementaryView(ofKind:
            kind, withReuseIdentifier: supplemantryId, for: indexPath)
        //suppView.frame.size.height  = 250
        return suppView
    }
}

