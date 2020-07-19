//
//  customHorizontalCollectionViewCell.swift
//  AppStore
//
//  Created by ahmad$$ on 2/27/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit
import SDWebImage

class customHorizontalCollectionViewCell: UICollectionViewCell {
    
    var app:App? {
        didSet{
            if let app = app {
                if let name = app.name {
                    titleLabel.text = name
                }
                if let categoryName = app.artistName {
                    categoryLabel.text = categoryName
                }
                if let url = app.artworkUrl100 {
                    iconImage.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder"))
                }
            }
        }
    }
    
    let iconImage : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 15
        image.contentMode = .scaleAspectFit
        image.layer.borderWidth = 0.25
        image.layer.borderColor = UIColor.systemGray.cgColor
//            (srgbRed: 1, green: 2, blue: 2, alpha: 2) as! CGColor
        image.clipsToBounds = true
        image.backgroundColor = .black
        //
        return image
    }()
    
    let titleLabel : UILabel = {
        let label                                             = UILabel()
        label.font                                            = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints       = false
        label.text                                            = "AppName"
        label.numberOfLines                                   = 2
        label.textColor                                       = .black
        //label.backgroundColor = .black
        
        return label
    }()
    
    let categoryLabel : UILabel = {
        let label                                            = UILabel()
        label.font                                           = UIFont.systemFont(ofSize: 13, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints      = false
        label.text                                           = "AppCategory"
        label.textColor                                      = .black
        //label.backgroundColor = .black


        return label
    }()
    
    let getButton : UIButton = {
        let button                                           = UIButton(type: UIButton.ButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints     = false
        button.backgroundColor                               = UIColor(white: 0.95, alpha: 1)
        button.layer.cornerRadius                            = 15
        button.titleLabel?.font                              = UIFont.boldSystemFont(ofSize: 16)
        button.setTitle("GET", for: .normal)
        button.addTarget(self, action: #selector(getButtonTaped), for: .touchUpInside)
        
        return button
    }()
    
    let horizontalStackView : UIStackView = {
        let stackView                                        = UIStackView()
        stackView.distribution                               = .fillProportionally
        stackView.axis                                       = .horizontal
        stackView.spacing                                    = 14
        stackView.alignment                                  = .center
        stackView.translatesAutoresizingMaskIntoConstraints  = false
        return stackView
    }()
    
    let verticalStackView : UIStackView = {
        let stackView                                        = UIStackView()
        stackView.distribution                               = .fill
        stackView.axis                                       = .vertical
        stackView.spacing                                    = 4
        stackView.alignment                                  = .leading
        stackView.translatesAutoresizingMaskIntoConstraints  = false

        return stackView
    }()
    
    let  seperatorView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.3, alpha: 0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @objc func getButtonTaped(_ sender : UIButton ) {
        sender.backgroundColor = .orange
    }
    
    func addingUIElemntsTotheView(){
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(categoryLabel)

        horizontalStackView.addArrangedSubview(iconImage)
        horizontalStackView.addArrangedSubview(verticalStackView)
        horizontalStackView.addArrangedSubview(getButton)
//        horizontalStackView.setCustomSpacing(80, after: horizontalStackView.arrangedSubviews[1])

        addSubview(horizontalStackView)
        addSubview(seperatorView)

    }
    
    func setupUIConstrains() {

        iconImage.widthAnchor.constraint(equalToConstant: 64).isActive         = true
        iconImage.heightAnchor.constraint(equalToConstant: 64).isActive         = true

        getButton.widthAnchor.constraint(equalToConstant: 70).isActive         = true
        getButton.heightAnchor.constraint(equalToConstant: 32).isActive         = true
//
        horizontalStackView.centerYAnchor.constraint(equalTo: self.layoutMarginsGuide.centerYAnchor).isActive       = true
        horizontalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive       = true
        horizontalStackView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive       = true
        horizontalStackView.rightAnchor.constraint(equalTo: self.layoutMarginsGuide.rightAnchor).isActive      = true
        //horizontalStackView.heightAnchor.constraint(equalToConstant: 69).isActive = true
        
        seperatorView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor ).isActive = true
        seperatorView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor ,constant:  -10 ).isActive = true

        seperatorView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor ).isActive = true
        seperatorView.heightAnchor.constraint(equalToConstant: 0.5 ).isActive = true

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .red
        addingUIElemntsTotheView()
        setupUIConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
