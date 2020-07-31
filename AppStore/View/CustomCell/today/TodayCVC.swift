//
//  TodayCVC.swift
//  AppStore
//
//  Created by Ahmad Khalil on 7/9/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit

class TodayCVC: TodayBaseCell {
    
    override var todayitem : todayItem? {
        didSet{
            if let todayitem = todayitem {
                imageView.image = todayitem.itemImage
                itemCategoryLabel.text = todayitem.itemTitle
                itemTitleLabel.text = todayitem.itemSubtitle
                itemDescriptionLabel.text = todayitem.itemDescription
                self.contentView.backgroundColor = todayitem.itemColor
            }
        }
    }

    let itemCategoryLabel =  UILabel(text: "itemCategoryLabel", font: .boldSystemFont(ofSize: 20))
    
    let itemTitleLabel = UILabel(text: "itemTitleLabel", font: .boldSystemFont(ofSize: 28))
    
    let itemDescriptionLabel = UILabel(text: "itemDescriptionLabel", font: .systemFont(ofSize: 16), numberOfLines: 3)
    
    let imageView : UIImageView = {
        let image = UIImageView(cornerRadius: 18)
        image.clipsToBounds = true
        return image
    }()
    
    let containerView : UIView = {
        let view =  UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let verticalStack : UIStackView = {
        let stack                                         = UIStackView()
        stack.axis                                        = .vertical
        stack.distribution                                = .fill
        stack.spacing                                     = 8
        stack.alignment                                   = .leading
        stack.translatesAutoresizingMaskIntoConstraints   = false
        return stack
       }()
    
    fileprivate func addingUIElemntsTotheView() {

        containerView.addSubview(imageView)
        
        verticalStack.addArrangedSubview(itemCategoryLabel)
        verticalStack.addArrangedSubview(itemTitleLabel)
        verticalStack.addArrangedSubview(containerView)
        verticalStack.addArrangedSubview(itemDescriptionLabel)
        
        addSubview(verticalStack)

    }
    
    fileprivate func setupUIConstrains() {
        
        imageView.centerInSuperview()
        imageView.constrainHeight(constant: 240 )
        imageView.constrainWidth(constant: 240 )

        containerView.anchor(top: nil, leading: verticalStack.safeAreaLayoutGuide.leadingAnchor , bottom: nil, trailing: verticalStack.safeAreaLayoutGuide.trailingAnchor )
        
        verticalStack.fillSuperviewWithPadding(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
           
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        contentView.backgroundColor = #colorLiteral(red: 0.9872588515, green: 0.9629482627, blue: 0.7360867262, alpha: 1)
//        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 18
        clipsToBounds = true
        
        addingUIElemntsTotheView()
        setupUIConstrains()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
