//
//  headercollectionView.swift
//  AppStore
//
//  Created by ahmad$$ on 2/28/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit
import SDWebImage

class headercollectionVC: UICollectionViewController {

    //MARK:- VC Properties and objects.
    
    private let cellId = "Cellid"
    var headerAppsArray : [headerApp]? = [headerApp]()
    let networkManager = NetworkManager()
    
    
    //MARK:- Setting up the UI elemnts Position.

    fileprivate func ConfigureCollectionView() {
        collectionView.register(HeaderCustomHorizontalCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset                                 = .init(top: 0, left: 15, bottom: 0, right: 15)
        collectionView.isScrollEnabled                              = true
        collectionView.backgroundColor                              = .white
        view.translatesAutoresizingMaskIntoConstraints              = false
        
        if let layout = collectionViewLayout as? headerFlowLayout {
            layout.scrollDirection                                  = .horizontal
        }
    }
    
    //MARK:- View Life Cycle.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConfigureCollectionView()
        getHeaderApps()
    }
    //MARK:- Data Configeration
    
    fileprivate func getHeaderApps() {
        networkManager.getHeaderApps { ( headerApps , error) in
            if let headerApps = headerApps {
                self.headerAppsArray = headerApps
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    

    //MARK:- collectionView DataSource and Delegate Methods.
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count  = headerAppsArray?.count {
            return count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HeaderCustomHorizontalCollectionViewCell
        //cell.backgroundColor = .white
        if let headerApp = headerAppsArray?[indexPath.row] {
            cell.headerApp = headerApp
        }
        return cell
    }
    
}
