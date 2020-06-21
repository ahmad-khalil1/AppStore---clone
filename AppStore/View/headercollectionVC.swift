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

    
    private let cellId = "Cellid"
    var headerAppsArray : [headerApp]? = [headerApp]()
    let networkManager = NetworkManager()

   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(HeaderCustomHorizontalCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.isScrollEnabled    = true
        
        view.translatesAutoresizingMaskIntoConstraints  = false
        if let layout = collectionViewLayout as? headerFlowLayout {
           // print("yes")
            layout.scrollDirection  = .horizontal
            //layout.itemSize         = CGSize(width: collectionView.bounds.inset(by: collectionView.layoutMargins).width, height: collectionView.bounds.inset(by: collectionView.layoutMargins).height)
        }
        collectionView.backgroundColor   = .white
        
        networkManager.getHeaderApps { ( headerApps , error) in
            if let headerApps = headerApps {
                self.headerAppsArray = headerApps
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }

    
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
