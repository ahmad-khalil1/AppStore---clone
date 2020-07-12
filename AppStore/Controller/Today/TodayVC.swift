//
//  TodayVC.swift
//  AppStore
//
//  Created by Ahmad Khalil on 7/9/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class TodayVC: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let collection = collectionView
        collection?.collectionViewLayout = UICollectionViewFlowLayout()
        collection?.delegate = self
        collection?.backgroundColor = .white
        collection?.contentInset = .init(top: 20 , left: 0, bottom: 20, right: 0)
        self.collectionView!.register(TodayCVC.self, forCellWithReuseIdentifier: reuseIdentifier)

        
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TodayCVC
        
        
        cell.imageView.image = #imageLiteral(resourceName: "holiday")
    
        return cell
    }

    
    private var isStatusBarHidden = false
    private var optionalSelectedCell : TodayCVC?
    private var hiddenCells: [TodayCVC] = []



}
// MARK: UICollectionViewDelegate
extension TodayVC : UICollectionViewDelegateFlowLayout {
    
    override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if collectionView.contentOffset.y < 0 || collectionView.contentOffset.y > collectionView.contentSize.height - collectionView.frame.height {
//            print("return triggerd ")
//            return
//        }
        
        let dampingRatio :CGFloat = 0.7
        let intialVelocity  = CGVector.zero
        let springParameters = UISpringTimingParameters(dampingRatio: dampingRatio, initialVelocity: intialVelocity)
        let animator = UIViewPropertyAnimator(duration: 0.5 , timingParameters: springParameters)
        
//        self.view.isUserInteractionEnabled = false
        if let selectedCell = optionalSelectedCell {
            isStatusBarHidden = false
            
            animator.addAnimations {
                selectedCell.collapse()
                for cell in self.hiddenCells {
                    cell.show()
                }
                self.tabBarController?.tabBar.frame.origin.y = self.view.frame.height+100
            }
            animator.addCompletion { (_) in
                self.optionalSelectedCell = nil
                collectionView.isScrollEnabled = true
                self.hiddenCells.removeAll()
            }
            
            
        }else{
            collectionView.isScrollEnabled = false
            let SelectedCell = collectionView.cellForItem(at: indexPath) as! TodayCVC
            let frameOfSelectedCell = SelectedCell.frame
            
            hiddenCells = collectionView.visibleCells.map{$0 as! TodayCVC }.filter{ $0 != SelectedCell}
            isStatusBarHidden = true
            
            animator.addAnimations {
                SelectedCell.expand(in: collectionView)
                for cell in self.hiddenCells {
                    cell.hide(in: collectionView, frameOfSelectedCell: frameOfSelectedCell)
                }
            }
            
            optionalSelectedCell = SelectedCell
        }
        animator.addAnimations {
            self.setNeedsStatusBarAppearanceUpdate()
        }
//        animator.addCompletion { _ in
//            self.view.isUserInteractionEnabled = true
//        }
        animator.startAnimation()


    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 50 , height: 400 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
