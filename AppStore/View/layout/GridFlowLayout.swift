//
//  GridFlowLayout.swift
//  AppStore
//
//  Created by ahmad$$ on 2/27/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit

class GridFlowLayout: UICollectionViewFlowLayout {

    let minRowHeight = CGFloat(59)
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else {return}
        
        let availabelWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
        let availabelHeight = collectionView.bounds.inset(by: collectionView.layoutMargins).height
//
//        let maxNumRows = Int(availabelHeight/minRowHeight)
//        let cellHeight = (availabelHeight/CGFloat(maxNumRows)).rounded(.down)
//        print((availabelHeight/3) - 3)
//        print(availabelWidth)
        
        self.itemSize = CGSize(width: availabelWidth - 12 , height: (availabelHeight/3) - 3)

    }
}
