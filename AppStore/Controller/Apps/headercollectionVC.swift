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
    
    //MARK:- View Life Cycle.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.contentInset                                    = .init(top: 0, left: 15, bottom: 0, right: 15)
        ConfigureCollectionView()
        getHeaderApps()
    }
    
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
    
    fileprivate func ConfigureCollectionView() {
        collectionView.register(HeaderCustomHorizontalCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.isScrollEnabled    = true
        collectionView.backgroundColor   = .white
        view.translatesAutoresizingMaskIntoConstraints  = false
        
        if let layout = collectionViewLayout as? headerFlowLayout {
            layout.scrollDirection  = .horizontal
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
        if let name = headerAppsArray?[indexPath.row].name {
            cell.titleLabel.text = name
        }
        if let tagline = headerAppsArray?[indexPath.row].tagline {
            cell.appDiscription.text = tagline
        }
        if let url = headerAppsArray?[indexPath.row].imageUrl {
            cell.appImage.sd_setImage(with: URL(string: url))
        }
        return cell
    }
    
}
