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
    
    let itemCategoryLabel : UILabel =  {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    let itemTitleLabel : UILabel =  {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 28)
        return label
    }()
    
    let itemDescriptionLabel : UILabel =  {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font =  .systemFont(ofSize: 16)
        label.numberOfLines =  3
        return label
    }()
          
    let imageView : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints  = false
//        image.backgroundColor                            = #colorLiteral(red: 0.9872588515, green: 0.9629482627, blue: 0.7360867262, alpha: 1)
        image.layer.cornerRadius                         = 18
        image.contentMode                                = .scaleAspectFill
//        image.clipsToBounds                              = true
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
//        addSubview(imageView)
        
        containerView.addSubview(imageView)
        
        
        verticalStack.addArrangedSubview(itemCategoryLabel)
        verticalStack.addArrangedSubview(itemTitleLabel)
        verticalStack.addArrangedSubview(containerView)
        verticalStack.addArrangedSubview(itemDescriptionLabel)
        
        addSubview(verticalStack)

    }
    
    fileprivate func setupUIConstrains() {
        
//        imageView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor , constant: 70 ).isActive  = true
//        imageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor ).isActive  = true
//        imageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive  = true
////        imageView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor ).isActive   = true
        
        imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 240).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 240).isActive = true
        
        containerView.leadingAnchor.constraint(equalTo: verticalStack.safeAreaLayoutGuide.leadingAnchor ).isActive = true
        containerView.trailingAnchor.constraint(equalTo: verticalStack.safeAreaLayoutGuide.trailingAnchor ).isActive = true

        verticalStack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor , constant:  24).isActive = true
        verticalStack.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor , constant:  24).isActive = true
        verticalStack.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor , constant:  -24).isActive = true
        verticalStack.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor , constant:  -24).isActive = true
        
        

        
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
