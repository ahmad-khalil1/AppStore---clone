//
//  AppDetailFlowLayout.swift
//  AppStore
//
//  Created by Ahmad Khalil on 6/24/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit

class AppDetailFlowLayout : UICollectionViewFlowLayout {
    
    let minColumnWidth = CGFloat(310)
//    var cellHeaight = CGFloat(330)
    var cellHeaight : CGFloat? {
        didSet{
            prepare()
        }
    }
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        let availabelWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
        let maxNumColumns = Int(availabelWidth/minColumnWidth)
        let cellWidth = (availabelWidth/CGFloat(maxNumColumns)).rounded(.down)
        
        
//        self.estimatedItemSize = CGSize(width: cellWidth, height: 1000)

        
        self.itemSize = CGSize(width: cellWidth, height: cellHeaight ?? 1 )
    }
}
