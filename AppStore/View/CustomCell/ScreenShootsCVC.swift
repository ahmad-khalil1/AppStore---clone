//
//  ScreenShootsCVC.swift
//  AppStore
//
//  Created by Ahmad Khalil on 6/30/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit
import SDWebImage

class ScreenShootsCVC: UICollectionViewCell {
    var app : appResult?   {
        didSet{
            if let imageURL = self.app?.screenshotUrls?.first {
                dummyUIImageView.sd_setImage(with: URL(string: imageURL)) { (image, e, t, u) in
                    self.imageSize = image?.size
                }
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    let dummyUIImageView = UIImageView()
    let verticalImageWidth : CGFloat = 220
    var imageSize: CGSize? {
        didSet {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            }
        }
    }
    
    fileprivate let cellId = "cellId"
    
    let PreviewTitleLAbel : UILabel = {
        let label = UILabel()
        label.font                                        = UIFont.boldSystemFont(ofSize: 20)
        label.text                                        = "Preview "
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
        addSubview(PreviewTitleLAbel)
        addSubview(collectionView)
    }
    
    fileprivate func setupUIConstrains() {
        
        PreviewTitleLAbel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor).isActive  = true
        PreviewTitleLAbel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor , constant: 15 ).isActive  = true
        PreviewTitleLAbel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor).isActive  = true
        PreviewTitleLAbel.heightAnchor.constraint(equalToConstant: 30).isActive = true

        collectionView.topAnchor.constraint(equalTo: PreviewTitleLAbel.bottomAnchor).isActive  = true
        collectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor ).isActive  = true
        collectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive  = true
        collectionView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor).isActive   = true
                
        
    }

    
    override init(frame: CGRect) {
          super.init(frame: frame)
        
        collectionView.register(ScreenShootsHorizantalCVC.self, forCellWithReuseIdentifier: cellId)
        collectionView.dataSource = self
        collectionView.delegate = self
        addingUIElemntsTotheView()
        setupUIConstrains()
        
      }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
      
}
extension ScreenShootsCVC : UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let minColumnWidth = CGFloat(310)
//        var cellHeaight = CGFloat(290)
//        let availabelWidth = collectionView.bounds.width
//        let maxNumColumns = Int(availabelWidth/minColumnWidth)
//        let cellWidth = (availabelWidth/CGFloat(maxNumColumns)).rounded(.down)
//        let width = collectionView.bounds.width - 30
//        let height = collectionView.bounds.height
       
        guard let previewCellSize = self.imageSize else { return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)}
        
        if previewCellSize.width > previewCellSize.height {
            let ratio = previewCellSize.width / previewCellSize.height
//            print("\(collectionView.frame.width / ratio)" + " height for the screenShot cell from size for item at   " )
            return CGSize(width: (self.contentView.frame.width - 35 ), height: collectionView.frame.width / ratio)
        } else {
            let ratio = previewCellSize.height / previewCellSize.width
//            print("\(verticalImageWidth * ratio)" + " size for the screenShot cell from size for item at   " )
            return CGSize(width: verticalImageWidth, height: (verticalImageWidth * ratio))
            
        }
        
//        return CGSize(width: 220 , height: 410)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return app?.screenshotUrls?.count ?? 3
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ScreenShootsHorizantalCVC
        if let screenShotURLs = app?.screenshotUrls {
            cell.screenShotImage.sd_setImage(with: URL(string: screenShotURLs[indexPath.row]), placeholderImage: UIImage(named: "placeholder"))
            
            //Debuggaging Prints
            //            print ("\(cell.screenShotImage.frame)" + "screenShotIMAgeView  frame  " )
            //            print ( "\(cell.screenShotImage.image?.size.width)" + "width  of the screenShotIMAgeView " )
            //            print (  "\(cell.frame)" + "screnShot cell"   )
            //            print("\(collectionView.frame)" + "Horizantel collectionView ")
        }
        return cell
    }
}


class ScreenShootsHorizantalCVC: UICollectionViewCell {
    
    let screenShotImage : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints  = false
        image.layer.cornerRadius                         = 8
        image.layer.borderWidth                          = 0.25
        image.layer.borderColor                          = UIColor.systemGray.cgColor
        image.backgroundColor                            = .black
        image.contentMode                                = .scaleAspectFill
        image.clipsToBounds                              = true
        return image
    }()
    
    fileprivate func setupUIConstrains(){
        screenShotImage.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor).isActive             = true
        screenShotImage.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive    = true
        screenShotImage.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive  = true
        screenShotImage.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor).isActive       = true
        
//        screenShotImage.heightAnchor.constraint(equalToConstant: 310).isActive  = true
//        screenShotImage.widthAnchor.constraint(equalToConstant: 250).isActive  = true

    }
    
    fileprivate func addingUIElemntsTotheView(){
        addSubview(screenShotImage)
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

