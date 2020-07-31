//
//  AppDetailVC.swift
//  AppStore
//
//  Created by Ahmad Khalil on 6/24/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit
import SDWebImage

class AppDetailVC : UIViewController {
    
    //MARK:- VC Properties and objects.
    
    fileprivate var id                     : String
    fileprivate var appDetail              : appResult?
    fileprivate var appReviewsArray        : [AppReviewEntry]?

    fileprivate let networkManager                             = NetworkManager()
    fileprivate let dispatchGroup                              = DispatchGroup()
    
    //MARK:- Enums Constans
    
    enum cells : Int  {
        case appDetailInfoCell
        case screenShootCell
        case appReviewCell
        
        static func count() -> Int {
            return appReviewCell.rawValue + 1
        }
    }
    
    enum cellsIdentifier : String {
        case appDetailInfoCellID
        case appScreenShotCellId
        case appReviewCellID
    }
    
    //MARK:- VC Initialization
    
    init(id: String){
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- UI Elements
    
    let collectionView : UICollectionView = {
        //        let layout = AppDetailFlowLayout()
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        
        
        layout.scrollDirection                               = . vertical
        collection.isScrollEnabled                           = true
        collection.allowsSelection                           = false
        collection.backgroundColor                           = .white
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    let activityIndicator : UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activity.color = .darkGray
        activity.startAnimating()
        activity.hidesWhenStopped = true
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    fileprivate func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(AppDetailInfoCVC.self, forCellWithReuseIdentifier: cellsIdentifier.appDetailInfoCellID.rawValue)
        collectionView.register(ScreenShootsCVC.self, forCellWithReuseIdentifier: cellsIdentifier.appScreenShotCellId.rawValue)
        collectionView.register(AppReviewCVC.self, forCellWithReuseIdentifier: cellsIdentifier.appReviewCellID.rawValue)
    }
    
    //MARK:- Setting up the UI elemnts Position.
    fileprivate func addingUIElemntsTotheView() {
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
    }
    
    fileprivate func setUpConstrains() {
        collectionView.fillSuperView()
//        collectionView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive   = true
//        collectionView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive     = true
        
        activityIndicator.centerInSuperview()
    }
    //MARK:- View Life Cycle.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        addingUIElemntsTotheView()
        setUpConstrains()
        
        setupCollectionView()
        
        fetchAppDetailData()
    }
    
    //MARK:- Data Configeration
    
    fileprivate func fetchAppDetailData() {
        dispatchGroup.enter()
        getAppDetail()
        dispatchGroup.enter()
        getAppDetailReviews()
        
        dispatchGroup.notify(queue: .main){
            self.activityIndicator.stopAnimating()
            self.collectionView.reloadData()
        }
    }
    
    fileprivate func getAppDetailReviews() {
        networkManager.getAppDetailReview(from: id) { (appReviews , error) in
            if let appReviews = appReviews{
                self.appReviewsArray = appReviews
                self.dispatchGroup.leave()
            }
        }
    }
    
    fileprivate func getAppDetail() {
        networkManager.getAppDetail(with: id) { (appDetail, error) in
            if let appDetail = appDetail {
                self.appDetail = appDetail
                self.dispatchGroup.leave()
                
            }
        }
    }
}

//MARK:- collectionView DataSource

extension AppDetailVC : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cells = cells(rawValue: indexPath.row) else  { return UICollectionViewCell()  }
        
        switch cells {
        case .appDetailInfoCell:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellsIdentifier.appDetailInfoCellID.rawValue, for: indexPath) as! AppDetailInfoCVC
            if let appDetail = self.appDetail{
                cell.appDetail = appDetail
            }
            return cell
        case .screenShootCell:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellsIdentifier.appScreenShotCellId.rawValue, for: indexPath) as! ScreenShootsCVC
            if let appDetail = self.appDetail{
                cell.app = appDetail
            }
            return cell
        case .appReviewCell:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellsIdentifier.appReviewCellID.rawValue, for: indexPath) as! AppReviewCVC
            cell.appReviewArray = self.appReviewsArray
            return cell
        }
    }
}

//MARK:- collectionView Delegate Methods.

extension AppDetailVC : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let minColumnWidth = CGFloat(310)
        var cellHeaight : CGFloat
        
        let availabelWidth = collectionView.bounds.width
        let maxNumColumns = Int(availabelWidth/minColumnWidth)
        let cellWidth = (availabelWidth/CGFloat(maxNumColumns)).rounded(.down)
        
        guard let cells = cells(rawValue: indexPath.row) else  { return CGSize(width: cellWidth, height: collectionView.frame.height)  }
        
        switch cells {
        case .appDetailInfoCell:
            cellHeaight = CGFloat(330)
            let dummyCell = AppDetailInfoCVC(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
            if let appDetail = self.appDetail{
                dummyCell.appDetail = appDetail
            }
            dummyCell.layoutIfNeeded()
            let estimatedSize = dummyCell.systemLayoutSizeFitting(CGSize(width: view.frame.width, height: 1000))
            return CGSize(width: cellWidth  , height: estimatedSize.height)
        case .screenShootCell:
            let dummyUIImageView = UIImageView()
            var imageSize: CGSize?
            if let appDetail = self.appDetail{
                if let imageURL = appDetail.screenshotUrls?.first {
                    dummyUIImageView.sd_setImage(with: URL(string: imageURL)) { (image, e, t, u) in
                        imageSize = image?.size
                    }
                }
            }
            guard let CellSize = imageSize else { return CGSize(width: cellWidth , height: collectionView.frame.height)}
            if CellSize.width > CellSize.height{
                cellHeaight = 280
            }else {
                cellHeaight = 460
            }
            return CGSize(width: cellWidth  , height: cellHeaight)
        case .appReviewCell:
            return CGSize(width: collectionView.frame.width  , height: 280)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
}

