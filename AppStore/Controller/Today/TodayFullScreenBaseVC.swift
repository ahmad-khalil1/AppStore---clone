//
//  TodayFullScreenBaseVC.swift
//  AppStore
//
//  Created by Ahmad Khalil on 7/31/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit

class TodayFullScreenBaseVC : UICollectionViewController , UICollectionViewDelegateFlowLayout {
    
    var completion : (() -> ())?
    var isCloseButtonHidden : Bool? {
        didSet{
        }
    }
    
    var todayItem : todayItem? {
        didSet{
        }
    }

    @objc func handelCloseButtonClicked(button : UIButton , gesture : UITapGestureRecognizer? = nil) {
        if let completion  = completion {
            completion()
        }
        
        button.alpha = 0
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
     }
     
     required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
}
