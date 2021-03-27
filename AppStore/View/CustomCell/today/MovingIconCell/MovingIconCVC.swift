//
//  MovingIconCVC.swift
//  AppStore
//
//  Created by Ahmad Khalil on 3/18/21.
//  Copyright © 2021 ahmad. All rights reserved.
//

import UIKit

class MovingIconCVC: TodayBaseCell {
    
    override var todayitem : todayItem? {
        didSet{
            if let todayitem = todayitem {
            }
        }
    }
    let mainLabel : UILabel = {
       let label = UILabel(text: "To get more Things Done faster", font: UIFont(name: "MYRIADPRO-SEMIBOLD", size: 30) ?? UIFont.systemFont(ofSize: 200), numberOfLines: 0 )
        
        return label
    }()
    let sublabel : UILabel = {
        let label = UILabel(text: "Key to succseful productivity   ", font: UIFont(name: "MYRIADPRO-REGULAR", size: 16) ?? UIFont.systemFont(ofSize: 200), numberOfLines: 0)
        label.textColor = UIColor.systemGray
        return label

    }()
    
    
    let movingIcon = MovingIconView(imagesArray: [ #imageLiteral(resourceName: "remmeberBear") , #imageLiteral(resourceName: "notability")  , #imageLiteral(resourceName: "lake") ,  #imageLiteral(resourceName: "Uylesse")  ,  #imageLiteral(resourceName: "CAFU")  ,  #imageLiteral(resourceName: "1password")    ,  #imageLiteral(resourceName: "bear")   , #imageLiteral(resourceName: "DropbOox") ,  #imageLiteral(resourceName: "3dMedical") , #imageLiteral(resourceName: "Shine") ], speed: 7 , multiplier: 3)
    
    func createVerticalStackView() {
        let containerView = UIView()
        let stack = UIStackView(verticalStackedViews: [sublabel , mainLabel])
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .extraLight))
        blur.frame = containerView.bounds
        blur.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.insertSubview(blur, at: 0)
        
        
        containerView.addSubview(stack)
        addSubview(containerView)

        
        stack.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.anchor(top: self.contentView.safeAreaLayoutGuide.topAnchor, leading:  self.contentView.safeAreaLayoutGuide.leadingAnchor, bottom: nil ,  trailing:  self.contentView.safeAreaLayoutGuide.trailingAnchor ,  size: .init(width: 0, height: 125))
        stack.anchor(top: containerView.topAnchor, leading:  containerView.leadingAnchor, bottom: nil ,  trailing:  containerView.trailingAnchor, padding: .init(top: 12, left: 24, bottom: 0, right: 24),  size: .init(width: 0, height: 100))
        
        
    }
    
    fileprivate func addingUIElemntsTotheView() {
        createVerticalStackView()
        addSubview(movingIcon)
        
    }
    
    fileprivate func setupUIConstrains() {
        movingIcon.fillSuperView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 18
        clipsToBounds = true
        contentView.backgroundColor = .white
        addingUIElemntsTotheView()
        setupUIConstrains()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
