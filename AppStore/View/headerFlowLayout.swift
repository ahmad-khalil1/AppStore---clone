//
//  headerFlowLayout.swift
//  AppStore
//
//  Created by ahmad$$ on 2/28/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit

class headerFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else {return}
        
        let availabelWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
        let availabelHeight = collectionView.bounds.inset(by: collectionView.layoutMargins).height
        //
        //        let maxNumRows = Int(availabelHeight/minRowHeight)
        //        let cellHeight = (availabelHeight/CGFloat(maxNumRows)).rounded(.down)
        print(availabelHeight)
        print(availabelWidth)
        
        self.itemSize = CGSize(width: availabelWidth - 10  , height: availabelHeight)
        
    }
}
