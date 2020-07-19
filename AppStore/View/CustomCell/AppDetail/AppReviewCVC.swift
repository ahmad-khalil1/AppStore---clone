//
//  AppReviewCVC.swift
//  AppStore
//
//  Created by Ahmad Khalil on 7/5/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit

class AppReviewCVC: UICollectionViewCell {
    
    var appReviewArray : [AppReviewEntry]? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
    fileprivate let cellId = "cellId"
    
    let reviewAndRatingTitleLAbel : UILabel = {
        let label = UILabel()
        label.font                                        = UIFont.boldSystemFont(ofSize: 18)
        label.text                                        = "Reviews & Ratings "
        label.textColor                                   = .black
        //        label.backgroundColor                             = .lightGray
        label.translatesAutoresizingMaskIntoConstraints   = false
        return label
    }()
    
    let collectionView : UICollectionView  = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame:CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection                               = .horizontal
        collection.isScrollEnabled                           = true
        collection.backgroundColor                           = .white
        collection.contentInset                              = .init(top: 0, left: 15, bottom: 0, right: 15)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    
    fileprivate func addingUIElemntsTotheView() {
        addSubview(reviewAndRatingTitleLAbel)
        addSubview(collectionView)
    }
    
    fileprivate func setupUIConstrains() {
        
        reviewAndRatingTitleLAbel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor).isActive  = true
        reviewAndRatingTitleLAbel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor , constant: 15 ).isActive  = true
        reviewAndRatingTitleLAbel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive  = true
        reviewAndRatingTitleLAbel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: reviewAndRatingTitleLAbel.bottomAnchor , constant: 20 ).isActive  = true
        collectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor ).isActive  = true
        collectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive  = true
        collectionView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor).isActive   = true
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(ReviewHorizantalCVC.self, forCellWithReuseIdentifier: cellId)
        collectionView.dataSource = self
        collectionView.delegate = self
        addingUIElemntsTotheView()
        setupUIConstrains()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AppReviewCVC : UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width  - 40  , height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appReviewArray?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ReviewHorizantalCVC
        if let appReview = self.appReviewArray?[indexPath.row] {
            cell.appReviewEntry = appReview
        }
        return cell
    }
}


class ReviewHorizantalCVC : UICollectionViewCell {
    
    var appReviewEntry : AppReviewEntry? {
        didSet{
            if let authorTitle = appReviewEntry?.authorNameLabel {
                authorTitleLAbel.text = authorTitle
            }
            if let reviewContent = appReviewEntry?.contentLabel {
                reviewBodyLAbel.text = reviewContent
            }
            if let reviewTitle = appReviewEntry?.titleLabel {
                reviewTitleLAbel.text = reviewTitle
            }
            if let rating = Int(appReviewEntry!.ratingLabel) {
                for (index , view ) in starStackView.arrangedSubviews.enumerated() {
                    view.alpha = index >= rating ? 0 : 1
                }
            }
        }
    }
    
    let reviewTitleLAbel : UILabel = {
        let label = UILabel()
        label.font                                        = UIFont.boldSystemFont(ofSize: 18)
        label.text                                        = "Review "
        label.textColor                                   = .black
//                label.backgroundColor                             = .lightGray
        label.translatesAutoresizingMaskIntoConstraints   = false
        return label
    }()
    
    let authorTitleLAbel : UILabel = {
        let label = UILabel()
        label.font                                        = UIFont.systemFont(ofSize: 12)
        label.text                                        = "Author "
        label.textColor                                   = .black
        //        label.backgroundColor                             = .lightGray
        label.translatesAutoresizingMaskIntoConstraints   = false
        return label
    }()
    

    let reviewBodyLAbel : UILabel = {
        let label = UILabel()
        label.font                                        = UIFont.systemFont(ofSize: 14)
        label.text                                        = "jnipa j[i njasd[iaiosja[s f falhbf ghkafbbh jfbghbaf bhafbgh bgfbhja bhljga hbfljahfg bhjabfhj gbakjf bhbaf hjgbabk fgbakhj fgbjh lfbgkbj akjfgkl akj j ablbfa  jh sgbhabfgb hjha bjhab fhjb gha h hbh fbjh bak bjh bjhbhj kfhjba bhbf jhabf ahksf  kah ab jahbkfjbafg f hbfjhgb habba fhg akfj  abfgha bhbasf ghabsfghba sfbf ghbhfj bkafbgb "
        label.textColor                                   = .black
        
        label.numberOfLines                               = 6
//        label.backgroundColor                             = .lightGray
        label.translatesAutoresizingMaskIntoConstraints   = false
        return label
    }()
    
    let starStackView : UIStackView = {
        var arrangedSubViews = [UIView]()
        (0..<5).forEach { _ in
            let imageView = UIImageView(image: #imageLiteral(resourceName: "star"))
//            imageView.contentMode = .scaleAspectFit
            imageView.widthAnchor.constraint(equalToConstant: 24 ).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 24 ).isActive = true
            arrangedSubViews.append(imageView)
        }
        let stack                                         = UIStackView(arrangedSubviews: arrangedSubViews)
        stack.axis                                        = .horizontal
        stack.distribution                                = .fillEqually
//        stack.spacing                                     = 2
        stack.alignment                                   = .leading
//        stack.backgroundColor = .blue
        stack.translatesAutoresizingMaskIntoConstraints   = false
        stack.addArrangedSubview(UIView())
        return stack
    }()
    
    
    let verticalStack : UIStackView = {
        let stack                                         = UIStackView()
        stack.axis                                        = .vertical
        stack.distribution                                = .fill
        stack.spacing                                     = 10
        stack.alignment                                   = .leading
        stack.backgroundColor = .red
        stack.translatesAutoresizingMaskIntoConstraints   = false
        return stack
    }()
    
    let horizantalStack : UIStackView = {
        let stack                                         = UIStackView()
        stack.axis                                        = .horizontal
        stack.distribution                                = .equalCentering
        stack.spacing                                     = 10
        stack.alignment                                   = .bottom
        stack.backgroundColor = .blue
        stack.translatesAutoresizingMaskIntoConstraints   = false
        return stack
    }()
    
    
    fileprivate func addingUIElemntsTotheView() {
        
        horizantalStack.addArrangedSubview(reviewTitleLAbel)
        horizantalStack.addArrangedSubview(authorTitleLAbel)
       
        
        verticalStack.addArrangedSubview(horizantalStack)
//        verticalStack.addArrangedSubview(stars)
        verticalStack.addArrangedSubview(starStackView)
        verticalStack.addArrangedSubview(reviewBodyLAbel)
        verticalStack.setCustomSpacing(10 , after: starStackView)
        addSubview(verticalStack)
    }
    
    fileprivate func setupUIConstrains() {
        authorTitleLAbel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        reviewTitleLAbel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        
        horizantalStack.leadingAnchor.constraint(equalTo: verticalStack.leadingAnchor  ).isActive  = true
        horizantalStack.trailingAnchor.constraint(equalTo: verticalStack.trailingAnchor ).isActive  = true
        
        //=============================================================================================
        horizantalStack.topAnchor.constraint(equalTo: verticalStack.topAnchor ).isActive  = true
        horizantalStack.heightAnchor.constraint(equalToConstant: 30 ).isActive  = true

//        stars.topAnchor.constraint(equalTo: horizantalStack.bottomAnchor , constant:  10 ).isActive = true
//        stars.heightAnchor.constraint(equalToConstant: 30 ).isActive  = true
        
        starStackView.topAnchor.constraint(equalTo: horizantalStack.bottomAnchor , constant:  10 ).isActive = true
//        starStackView.leadingAnchor.constraint(equalTo: verticalStack.leadingAnchor  ).isActive  = true
//        starStackView.trailingAnchor.constraint(equalTo: verticalStack.trailingAnchor ).isActive  = true
        starStackView.heightAnchor.constraint(equalToConstant: 30 ).isActive  = true

        reviewBodyLAbel.topAnchor.constraint(equalTo: starStackView.bottomAnchor , constant:  10 ).isActive = true

//        =============================================================================================
//        reviewBodyLAbel.heightAnchor.constraint(equalToConstant: 140 ).isActive  = true

        //        reviewBodyLAbel.bottomAnchor.constraint(equalTo: verticalStack.bottomAnchor , constant:  -20 ).isActive = true


        
        verticalStack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor , constant: 20 ).isActive  = true
        verticalStack.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor , constant: 20 ).isActive  = true
        verticalStack.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor , constant: -20).isActive  = true
//        verticalStack.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor , constant: -20).isActive   = true
//
//        verticalStack.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor , constant: -40).isActive   = true
//        verticalStack.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor , constant: -40).isActive   = true

        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.backgroundColor = .systemGray5
        self.contentView.layer.cornerRadius = 18
        clipsToBounds = true
        addingUIElemntsTotheView()
        setupUIConstrains()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}





//    let stars : UILabel = {
//        let label = UILabel()
//        label.font                                        = UIFont.systemFont(ofSize: 15)
//        label.text                                        = "..... Stars ....... "
//        label.textColor                                   = .black
//                label.backgroundColor                             = .lightGray
//        label.translatesAutoresizingMaskIntoConstraints   = false
//        return label
//    }()
    
//    let starImageView : UIImageView = {
//        let image = UIImageView()
//        image.translatesAutoresizingMaskIntoConstraints  = false
//        //        image.layer.cornerRadius                         = 8
//        //        image.layer.borderWidth                          = 0.25
//        //        image.layer.borderColor                          = UIColor.systemGray.cgColor
//        //        image.backgroundColor                            = .black
//        image.contentMode                                = .scaleAspectFill
//        image.clipsToBounds                              = true
//        return image
//    }()
//



//        let arrangedSTarImageViewsArray : [UIImageView] = creatStarArrangedView()
//        let starStackView : UIStackView = creatStarStackView(from: arrangedSTarImageViewsArray)
//




//        (0...5).forEach{ _ in
//            starImageView.image = #imageLiteral(resourceName: "star")
//            starStackView.addArrangedSubview(starImageView)
//        }
//        var imageViewArray = [UIImageView]()
//        for _ in 0...4 {
//            var imageView : UIImageView
//            imageView = starImageView
//            imageView.image = #imageLiteral(resourceName: "star")
//            imageViewArray.append(imageView)
//        }
////        print(imageViewArray.count)
//        addArrangdSubviewsArray(for: starStackView, imageViewArray)
        
//        print("stackCount " + "\(starStackView.arrangedSubviews.count)")
//        starStackView.addArrangedSubview(UIView())





//    fileprivate func addArrangdSubviewsArray<T : UIView>(for Stack : UIStackView ,_ array : Array<T> ) {
//        for index in 0...4 {
//
//        }
//
//
//        for index in 0...array.count - 1  {
//            Stack.addArrangedSubview(array[index])
//        }
//        print(array.count)
//        print("stackCount in Func " + "\(Stack.arrangedSubviews.count)")
//        print("starStackCount in Func " + "\(Stack.arrangedSubviews.count)")
//
//
//    }
//
//    func creatStarArrangedView() -> Array<UIImageView>{
//        var imageViewArray = [UIImageView]()
//        for _ in 0...4 {
//            let starImageView : UIImageView = {
//                let image = UIImageView()
//                image.translatesAutoresizingMaskIntoConstraints  = false
//                //        image.layer.cornerRadius                         = 8
//                //        image.layer.borderWidth                          = 0.25
//                //        image.layer.borderColor                          = UIColor.systemGray.cgColor
//                //        image.backgroundColor                            = .black
//                image.contentMode                                = .scaleAspectFill
//                image.clipsToBounds                              = true
//                return image
//            }()
//            starImageView.image = #imageLiteral(resourceName: "star")
//            imageViewArray.append(starImageView)
//        }
//        return imageViewArray
//    }

   
//    func creatStarStackView<T : UIView>(from array : Array<T>) -> UIStackView {
//        let stack                                         = UIStackView(arrangedSubviews: array)
//        stack.axis                                        = .horizontal
//        stack.distribution                                = .fill
//        stack.spacing                                     = 2
//        stack.alignment                                   = .leading
//        //        stack.backgroundColor = .blue
//        stack.translatesAutoresizingMaskIntoConstraints   = false
//        stack.addArrangedSubview(UIView())
//
//        stack.topAnchor.constraint(equalTo: horizantalStack.bottomAnchor , constant:  10 ).isActive = true
//        stack.leadingAnchor.constraint(equalTo: verticalStack.leadingAnchor  ).isActive  = true
//        stack.trailingAnchor.constraint(equalTo: verticalStack.trailingAnchor ).isActive  = true
//        stack.heightAnchor.constraint(equalToConstant: 30 ).isActive  = true
//
//        reviewBodyLAbel.topAnchor.constraint(equalTo: stack.bottomAnchor , constant:  20 ).isActive = true
//        return stack
//
//    }
