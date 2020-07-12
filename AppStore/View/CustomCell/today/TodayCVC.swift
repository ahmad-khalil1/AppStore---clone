//
//  TodayCVC.swift
//  AppStore
//
//  Created by Ahmad Khalil on 7/9/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit

class TodayCVC: ExpandableCollectionViewCell {
    
    let imageView : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints  = false
        image.backgroundColor                            = #colorLiteral(red: 0.9872588515, green: 0.9629482627, blue: 0.7360867262, alpha: 1)
        image.layer.cornerRadius                         = 18
        image.contentMode                                = .scaleAspectFit
        image.clipsToBounds                              = true
        return image
    }()
    
    fileprivate func addingUIElemntsTotheView() {
        addSubview(imageView)
        
    }
    
    fileprivate func setupUIConstrains() {
        
//        imageView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor , constant: 70 ).isActive  = true
//        imageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor ).isActive  = true
//        imageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive  = true
////        imageView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor ).isActive   = true
        
        imageView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 240).isActive = true
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = #colorLiteral(red: 0.9872588515, green: 0.9629482627, blue: 0.7360867262, alpha: 1)
        contentView.layer.cornerRadius = 18
        clipsToBounds = true
        
        
        addingUIElemntsTotheView()
        setupUIConstrains()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
