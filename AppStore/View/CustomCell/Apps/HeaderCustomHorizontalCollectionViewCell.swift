//
//  HeaderCustomHorizontalCollectionViewCell.swift
//  AppStore
//
//  Created by ahmad$$ on 2/28/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit

class HeaderCustomHorizontalCollectionViewCell: UICollectionViewCell {
    
    var headerApp : headerApp? {
        didSet{
            if let name = headerApp?.name {
                titleLabel.text = name
            }
            if let tagline = headerApp?.tagline {
                appDiscription.text = tagline
            }
            if let url = headerApp?.imageUrl {
                appImage.sd_setImage(with: URL(string: url))
            }
        }
    }
      
    let verticalStackView : UIStackView = {
        let view = UIStackView()
        view.distribution                                = .fill
        view.alignment                                   = .leading
        view.axis                                        = .vertical
        view.spacing                                     = 10
        view.translatesAutoresizingMaskIntoConstraints   = false
        
        return view
    }()
    
    let appDiscription : UILabel = {
        
        let label                                             = UILabel()
        label.font                                            = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints       = false
        label.numberOfLines                                   = 0
        //label.text                                            = "Keeping up with friends is faster than ever "
        label.textColor                                       = .black
        //label.backgroundColor = .black
        return label
    }()
    
    let titleLabel : UILabel = {
        let label                                             = UILabel()
        label.font                                            = UIFont.systemFont(ofSize: 12
        )
        label.translatesAutoresizingMaskIntoConstraints       = false
       // label.text                                            = "Facebook"
        label.textColor                                       = .black
        //label.backgroundColor = .black
        
        return label
    }()
    
    let appImage : UIImageView = {
        let image                                            = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints      = false
        image.layer.cornerRadius                             = 8
        image.contentMode                                    = .scaleAspectFill
        //image.layer.borderWidth = 0.25
        //image.layer.borderColor = (srgbRed: 1, green: 2, blue: 2, alpha: 2) as! CGColor
        image.clipsToBounds = true
        //image.backgroundColor                                = .gray
        //
        return image
    }()
    
    
    func setupUIConstrains(){
        verticalStackView.topAnchor.constraint(equalTo: self.topAnchor , constant: 5).isActive    = true
        verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive    = true
        verticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive    = true
        verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive    = true

        appImage.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor  ).isActive   = true
       // appImage.widthAnchor.constraint(equalToConstant: 100).isActive   = true

    }
    
    func addingUIElemntsTotheView(){
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(appDiscription)
        verticalStackView.addArrangedSubview(appImage)

        addSubview(verticalStackView)
    }
    override init(frame: CGRect) {
           super.init(frame: frame)
       // print("here is the cell")
           //backgroundColor = .red
           addingUIElemntsTotheView()
           setupUIConstrains()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
}
