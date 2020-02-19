//
//  CustomViewCell.swift
//  AppStore
//
//  Created by ahmad$$ on 2/14/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit    

class CustomViewCell: UICollectionViewCell {
    
    //MARK:- intializing the UI elemnts
    
    let iconImage : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 8
        //image.clipsToBounds = true
        image.backgroundColor = .systemRed
        
        return image
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "AppName"
        label.textColor = .black
        //label.backgroundColor = .black
        
        return label
    }()
    
    let categoryLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "appCategory"
        label.textColor = .black
        //label.backgroundColor = .black


        return label
    }()
    
    let ratingLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ratings"
        label.textColor = .black
        //label.backgroundColor = .black

        return label
    }()
    
    let getButton : UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemTeal
        button.layer.cornerRadius = 15
        button.setTitle("get", for: .normal)
        button.addTarget(self, action: #selector(getButtonTaped), for: .touchUpInside)
        
        return button
    }()
    
    @objc func getButtonTaped(_ sender : UIButton ) {
        sender.backgroundColor = .orange
    }
    
    let appImages : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 5
        //image.clipsToBounds = true
        image.backgroundColor = .green
        
        return image
    }()
    let appImages1 : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 5
        //image.clipsToBounds = true
        image.backgroundColor = .systemOrange
        
        return image
    }()
    let appImages2 : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 5
        //image.clipsToBounds = true
        image.backgroundColor = .blue
        
        return image
    }()
    
    let appImages3 : UIImageView = {
          let image = UIImageView()
          image.translatesAutoresizingMaskIntoConstraints = false
          image.layer.cornerRadius = 5
          //image.clipsToBounds = true
          image.backgroundColor = .black
          
          return image
      }()
    
    let containerView : UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .none
        return view
    }()
    
    let stackView : UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .fill
        //view.backgroundColor = .orange
        view.distribution = .fillEqually
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func addingUIElemntsTotheView(){
        containerView.addSubview(iconImage)
        containerView.addSubview(titleLabel)
        containerView.addSubview(categoryLabel)
        containerView.addSubview(ratingLabel)
        containerView.addSubview(getButton)
        addSubview(containerView)
        stackView.addArrangedSubview(appImages1)
        stackView.addArrangedSubview(appImages)
        stackView.addArrangedSubview(appImages2)
        addSubview(stackView)
        
        


    }
    
    func setupUIConstrains(){
        
        NSLayoutConstraint.activate([
            
            containerView.leftAnchor.constraint(equalTo: self.layoutMarginsGuide.leftAnchor),
            containerView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor , constant: 10),
            containerView.rightAnchor.constraint(equalTo: self.layoutMarginsGuide.rightAnchor  ),
            containerView.heightAnchor.constraint(equalToConstant: 59),
           // containerView.widthAnchor.constraint(equalTo: self.layoutMarginsGuide.widthAnchor, multiplier: 1, constant: -10),
            
            
            iconImage.leftAnchor.constraint(equalTo: containerView.leftAnchor),
            iconImage.topAnchor.constraint(equalTo:containerView.topAnchor),
            iconImage.heightAnchor.constraint(equalToConstant: 59),
            iconImage.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.2, constant: -7),
            
            titleLabel.leftAnchor.constraint(equalTo: iconImage.rightAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor , constant: 2 ),
            titleLabel.heightAnchor.constraint(equalToConstant: 16),
            titleLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.6, constant: -10),
            
            categoryLabel.leftAnchor.constraint(equalTo: iconImage.rightAnchor, constant:12),
            categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3),
            categoryLabel.heightAnchor.constraint(equalToConstant: 16),
            categoryLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.6, constant: -10),
            
            ratingLabel.leftAnchor.constraint(equalTo: iconImage.rightAnchor, constant: 12),
            ratingLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 3),
            ratingLabel.heightAnchor.constraint(equalToConstant: 16),
            ratingLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.6, constant: -10),
            
            getButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            getButton.rightAnchor.constraint(equalTo: containerView.rightAnchor ),
            getButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.2),
            getButton.heightAnchor.constraint(equalToConstant: 30),

            stackView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor  , constant: -10),
            stackView.leftAnchor.constraint(equalTo: self.layoutMarginsGuide.leftAnchor),
            //stackView.widthAnchor.constraint(equalTo: self.layoutMarginsGuide.widthAnchor, multiplier: 1, constant: -10),
            stackView.rightAnchor.constraint(equalTo: self.layoutMarginsGuide.rightAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 214),
            
//            appImages1.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 17),
//            appImages1.leftAnchor.constraint(equalTo: appImages.rightAnchor , constant: 5),
//            appImages1.widthAnchor.constraint(equalTo: self.layoutMarginsGuide.widthAnchor, multiplier: 0.3, constant: -10),
//            appImages1.heightAnchor.constraint(equalToConstant: 214),
//
//            appImages2.topAnchor.constraint(equalTo: iconImage.bottomAnchor, constant: 17),
//            appImages2.leftAnchor.constraint(equalTo: appImages1.rightAnchor , constant: 5),
//            appImages2.widthAnchor.constraint(equalTo: self.layoutMarginsGuide.widthAnchor, multiplier: 0.3, constant: -10),
//            appImages2.heightAnchor.constraint(equalToConstant: 214),


            
            
            
            
        ])
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addingUIElemntsTotheView()
        setupUIConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
