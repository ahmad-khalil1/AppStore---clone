//
//  AppsColumnFlowLayout.swift
//  AppStore
//
//  Created by ahmad$$ on 2/27/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit

class AppsColumnFlowLayout: UICollectionViewFlowLayout {
    
    let minColumnWidth = CGFloat(310)
    var cellHeaight = CGFloat(290)
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else {return}
        
        let availabelWidth = collectionView.bounds.width
        let maxNumColumns = Int(availabelWidth/minColumnWidth)
        let cellWidth = (availabelWidth/CGFloat(maxNumColumns)).rounded(.down)
        
        self.itemSize = CGSize(width: cellWidth, height: cellHeaight )
        self.headerReferenceSize = CGSize(width: collectionView.bounds.inset(by: collectionView.layoutMargins).width , height: 270)
        //        self.sectionInset = UIEdgeInsets(top: -20 , left: -20, bottom: -20, right: -20)
        //        self.sectionInsetReference = .fromSafeArea
        
    }
}
