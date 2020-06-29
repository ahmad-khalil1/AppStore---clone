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
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast

        let availabelWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
        let availabelHeight = collectionView.bounds.inset(by: collectionView.layoutMargins).height
//
//        let maxNumRows = Int(availabelHeight/minRowHeight)
//        let cellHeight = (availabelHeight/CGFloat(maxNumRows)).rounded(.down)
//        print((availabelHeight/3) - 3)
//        print(availabelWidth)
        
        self.itemSize = CGSize(width: availabelWidth - 12 , height: (availabelHeight/3) - 3)

    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
         guard let collectionView = collectionView else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity) }

         var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalOffset = proposedContentOffset.x + collectionView.contentInset.left

         let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)

         let layoutAttributesArray = super.layoutAttributesForElements(in: targetRect)

        layoutAttributesArray?.forEach({ (layoutAttributes) in
            let itemOffset = layoutAttributes.frame.origin.x
            let itemWidth = Float(layoutAttributes.frame.width)
            let direction: Float = velocity.x > 0 ? 1 : -1
            if fabsf(Float(itemOffset - horizontalOffset)) < fabsf(Float(offsetAdjustment)) + itemWidth * direction  {                 offsetAdjustment = itemOffset - horizontalOffset             }         })

        return CGPoint(x: proposedContentOffset.x + offsetAdjustment - sectionInset.left, y: proposedContentOffset.y)
        
    }
}
