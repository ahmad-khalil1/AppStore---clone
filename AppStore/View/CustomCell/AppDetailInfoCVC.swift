//
//  AppDetailInfoCVC.swift
//  AppStore
//
//  Created by Ahmad Khalil on 6/24/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit

class AppDetailInfoCVC: UICollectionViewCell {
 
    var textCount : Int?
    
    var appTitleTextCount : Int? {
        didSet{
            if let count = appTitleTextCount {
                count < 19 ?  verticalStack.setCustomSpacing(30, after: createdCompanyOfAppLabel) : verticalStack.setCustomSpacing(15, after: createdCompanyOfAppLabel)
            }
        }
    }
    
    var hasPrice : Bool? {
        didSet{
            if let hasPrice = hasPrice {
                if hasPrice {
                    getButton.widthAnchor.constraint(equalToConstant: 110).isActive         = true
                }else {
                    getButton.widthAnchor.constraint(equalToConstant: 70).isActive         = true
                }
            }
        }
    }
    
//    lazy var width: NSLayoutConstraint = {
//        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
//        width.isActive = true
//        return width
//    }()
    //
    
//    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
//        width.constant = bounds.size.width
//        contentView.layoutIfNeeded()
//        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
//        
//    }
    
    
    
    let iconImage : UIImageView = {
        let image                                         = UIImageView()
        image.backgroundColor                             = .black
        image.contentMode                                 = .scaleAspectFit
        image.clipsToBounds                               = true
        image.layer.cornerRadius                          = 25
        image.translatesAutoresizingMaskIntoConstraints   = false
        
        return image
    }()
    
    let appTitleLabel : UILabel = {
        let label                                         = UILabel()
        label.font                                        = UIFont.boldSystemFont(ofSize: 23)
       // label.text                                        = "App"
        label.textColor                                   = .black
        label.numberOfLines                               = 0
//        label.backgroundColor                             = .lightGray
        label.translatesAutoresizingMaskIntoConstraints   = false
        return label
    }()
    
    let createdCompanyOfAppLabel : UILabel = {
        let label                                         = UILabel()
        label.font                                        = UIFont.systemFont(ofSize: 16)
        label.text                                        = "App Company"
        label.textColor                                   = .black
//        label.backgroundColor                             = .lightGray
        label.translatesAutoresizingMaskIntoConstraints   = false
        return label
    }()
    
    let getButton : UIButton = {
        let button                                        = UIButton(type:.system)
        button.backgroundColor                            = UIColor(white: 0.95, alpha: 1)
        button.layer.cornerRadius                         = 15
        button.titleLabel?.font                           = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints  = false
        button.setTitle("GET", for: .normal)
        return button
    }()
    
    let whatsNewLabel : UILabel = {
        let label = UILabel()
        label.font                                        = UIFont.systemFont(ofSize: 15)
        label.text                                        = "What's New....."
        label.textColor                                   = .black
//        label.backgroundColor                             = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints   = false
        return label
    }()
    
    let releasingNotesLabel : UILabel = {
        let label                                         = UILabel()
        label.font                                        = UIFont.systemFont(ofSize: 15)
//        label.text                                        = "nashf amsdgbkljahsfgansfkhbgakhsfgbaf asngjlnaskfn asfjkansf;g asfgafsng ljalshjfgjk afhgk jafhg jkafgkljahgals akfhg kafhsg jasfgljasf gklafksjg jjhfgl akfjhga kjlsfhgklahsfkg akfhgkl jahsfg kjlahfafgalsfjgafgasflj h jfgkl hakjsl ghajshgkajs fgkjashgkjah akjsf hajsfh ajkf gkah ajfhgkahfglkjahfskjahg lkahf kjahsjf gjhasf gafh gljka fjkgasfau f k hashg ajfs hlasf jh "
        label.numberOfLines                               = 0
        label.textColor                                   = .black
//        label.backgroundColor                             = .lightGray
        label.translatesAutoresizingMaskIntoConstraints   = false
        return label
    }()
    
    let verticalStack : UIStackView = {
        let stack                                         = UIStackView()
        stack.axis                                        = .vertical
        stack.distribution                                = .fill
        stack.spacing                                     = 7
        stack.alignment                                   = .leading
        stack.translatesAutoresizingMaskIntoConstraints   = false
        return stack
    }()
    let horizantalStack : UIStackView = {
        let stack                                         = UIStackView()
        stack.axis                                        = .horizontal
        stack.distribution                                = .fillProportionally
        stack.spacing                                     = 18
        stack.alignment                                   = .leading
        stack.translatesAutoresizingMaskIntoConstraints   = false
        return stack
    }()
    
    fileprivate func addingUIElemntsTotheView() {
        verticalStack.addArrangedSubview(appTitleLabel)
        verticalStack.addArrangedSubview(createdCompanyOfAppLabel)
        verticalStack.addArrangedSubview(getButton)
        
        horizantalStack.addArrangedSubview(iconImage)
        horizantalStack.addArrangedSubview(verticalStack)
        
        addSubview(horizantalStack)
        addSubview(whatsNewLabel)
        addSubview(releasingNotesLabel)
    }
    
    fileprivate func setupUIConstrains() {
                 
        iconImage.widthAnchor.constraint(equalToConstant: 120).isActive         = true
        iconImage.heightAnchor.constraint(equalToConstant: 120).isActive         = true
        
//        getButton.widthAnchor.constraint(equalToConstant: 70).isActive         = true
        getButton.heightAnchor.constraint(equalToConstant: 32).isActive         = true
        
//        iconImage.topAnchor.constraint(equalTo: verticalStack.topAnchor).isActive = true
       // createdCompanyOfAppLabel.topAnchor.constraint(equalTo: appTitleLabel.bottomAnchor, constant: 2).isActive  = true
    
        getButton.bottomAnchor.constraint(equalTo: verticalStack.bottomAnchor).isActive = true
        
        verticalStack.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        horizantalStack.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor).isActive  = true
        horizantalStack.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive  = true
        horizantalStack.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive  = true
        horizantalStack.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        whatsNewLabel.topAnchor.constraint(equalTo: horizantalStack.bottomAnchor , constant: 15).isActive  = true
        whatsNewLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive  = true
        whatsNewLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive  = true
        whatsNewLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        releasingNotesLabel.topAnchor.constraint(equalTo: whatsNewLabel.bottomAnchor, constant: 10).isActive  = true
        releasingNotesLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor).isActive  = true
        releasingNotesLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive  = true
        releasingNotesLabel.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor).isActive   = true
        
        if let lastSubview = contentView.subviews.last {
            contentView.bottomAnchor.constraint(equalTo: lastSubview.bottomAnchor, constant: 10).isActive = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addingUIElemntsTotheView()
        setupUIConstrains()
        //self.systemLayoutSizeFitting(<#T##targetSize: CGSize##CGSize#>)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
