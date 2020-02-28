//
//  appsCustomViewCell.swift
//  AppStore
//
//  Created by ahmad$$ on 2/27/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit

class appsCustomViewCell: UICollectionViewCell {
    //MARK:- intializing the UI elemnts
    
//    let iconImage : UIImageView = {
//        let image = UIImageView()
//        image.translatesAutoresizingMaskIntoConstraints = false
//        image.layer.cornerRadius = 10
//        image.contentMode = .scaleAspectFit
//        //image.layer.borderWidth = 0.25
//        //image.layer.borderColor = (srgbRed: 1, green: 2, blue: 2, alpha: 2) as! CGColor
//        image.clipsToBounds = true
//        image.backgroundColor = .systemRed
//        //
//        return image
//    }()
//
//    let titleLabel : UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "AppName"
//        label.textColor = .black
//        label.backgroundColor = .black
//
//        return label
//    }()
//
//    let categoryLabel : UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "appCategory"
//        label.textColor = .black
//        label.backgroundColor = .black
//
//
//        return label
//    }()
//
//    let ratingLabel : UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "ratings"
//        label.textColor = .black
//        label.backgroundColor = .black
//
//        return label
//    }()
//
//    let getButton : UIButton = {
//        let button = UIButton(type: UIButton.ButtonType.system)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.backgroundColor = .systemGray6
//        button.layer.cornerRadius = 15
//        button.setTitle("GET", for: .normal)
//        button.addTarget(self, action: #selector(getButtonTaped), for: .touchUpInside)
//
//        return button
//    }()
    let titleLabel : UILabel = {
     let label =  UILabel()
        label.text = "App Section"
        label.font = .boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let horizontalController = AppsHorizontalController()
    
    func addingUIElemntsTotheView(){
        addSubview(titleLabel)
        addSubview(horizontalController.view)

    }
    
    func setupUIConstrains(){

        titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive              = true
        titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor , constant: 15).isActive      = true
        titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive    = true

        horizontalController.view.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        horizontalController.view.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        horizontalController.view.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        horizontalController.view.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc func getButtonTaped(_ sender : UIButton ) {
        sender.backgroundColor = .orange
    }   
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        backgroundColor = .lightGray
//        horizontalController.view.backgroundColor = .blue
        
        addingUIElemntsTotheView()
        setupUIConstrains()

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
