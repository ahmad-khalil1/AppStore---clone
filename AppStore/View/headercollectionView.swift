//
//  headercollectionView.swift
//  AppStore
//
//  Created by ahmad$$ on 2/28/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit


class headercollectionView: UICollectionViewController {

    
    private let cellId = "Cellid"

   
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
    }

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HeaderCustomHorizontalCollectionViewCell
        //cell.backgroundColor = .white
        return cell
    }
    


}
