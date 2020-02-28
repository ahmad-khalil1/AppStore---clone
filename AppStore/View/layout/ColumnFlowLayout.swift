//
//  ColumnFlowLayout.swift
//  AppStore
//
//  Created by ahmad$$ on 2/16/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit

class ColumnFlowLayout: UICollectionViewFlowLayout {
    
    let minColumnWidth = CGFloat(310)
    var cellHeaight = CGFloat(330)
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else {return}
        
        let availabelWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
        let maxNumColumns = Int(availabelWidth/minColumnWidth)
        let cellWidth = (availabelWidth/CGFloat(maxNumColumns)).rounded(.down)
        
        self.itemSize = CGSize(width: cellWidth, height: cellHeaight )
//        self.sectionInset = UIEdgeInsets(top: -20 , left: -20, bottom: -20, right: -20)
//        self.sectionInsetReference = .fromSafeArea

    }
}
