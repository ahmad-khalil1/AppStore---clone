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
    
    fileprivate let cellId                = "cellId"
    fileprivate var appDetail             = appResult()
    fileprivate let networkManager        = NetworkManager()
    let dispatchGroup                     = DispatchGroup()
    
    fileprivate var id : String

    
    init(id: String){
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let collectionView : UICollectionView = {
//        let layout = AppDetailFlowLayout()
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
     
        
        layout.scrollDirection                               = . vertical
        collection.isScrollEnabled                           = true
        collection.backgroundColor                           = .white
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    fileprivate func setUpConstrains() {
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive         = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive   = true
        collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive       = true
        collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive     = true
        
        collectionView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive   = true
        collectionView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive     = true
        print("done with collectionView layout ")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        view.addSubview(collectionView)
        setUpConstrains()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(AppDetailInfoCVC.self, forCellWithReuseIdentifier: cellId)
        dispatchGroup.enter()
        getAppDetail()
        dispatchGroup.notify(queue: .main){
            DispatchQueue.main.async {
                self.collectionView.reloadData()
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



extension AppDetailVC : UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {


        let minColumnWidth = CGFloat(310)
        var cellHeaight = CGFloat(330)

        let availabelWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
        let maxNumColumns = Int(availabelWidth/minColumnWidth)
        let cellWidth = (availabelWidth/CGFloat(maxNumColumns)).rounded(.down)

        let dummyCell = AppDetailInfoCVC(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))

        if let name                               = appDetail.trackName {
            dummyCell.appTitleLabel.text               = name
            dummyCell.appTitleTextCount                = name.count
        }
        if let companyName  = appDetail.sellerName {
            dummyCell.createdCompanyOfAppLabel.text = companyName
        }
        if let releaseNotes =  appDetail.releaseNotes {
            dummyCell.releasingNotesLabel.text = releaseNotes
        }
        if let iconImageUrl = appDetail.artworkUrl512 {
            dummyCell.iconImage.sd_setImage(with: URL(string: iconImageUrl) , placeholderImage: UIImage(named: "placeholder") )
        }

        if let price = appDetail.price , let curreny = appDetail.currency{
            if price != 0 {
                dummyCell.getButton.setTitle("\(String(price)) \(curreny)", for: .normal)
                dummyCell.hasPrice = true
            }else{
                dummyCell.hasPrice = false
            }
        }

        dummyCell.layoutIfNeeded()
        let estimatedSize = dummyCell.systemLayoutSizeFitting(CGSize(width: view.frame.width, height: 1000))

        print("done")
//        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//        print("done")
//        layout.itemSize = CGSize(width: cellWidth, height: cellHeaight)
//        }

        return CGSize(width: cellWidth  , height: estimatedSize.height)
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppDetailInfoCVC
        if let name                               = appDetail.trackName {
            cell.appTitleLabel.text               = name
            cell.appTitleTextCount                = name.count
        }
        if let companyName  = appDetail.sellerName {
            cell.createdCompanyOfAppLabel.text = companyName
        }
        if let releaseNotes =  appDetail.releaseNotes {
            cell.releasingNotesLabel.text = releaseNotes
        }
        if let iconImageUrl = appDetail.artworkUrl512 {
            cell.iconImage.sd_setImage(with: URL(string: iconImageUrl) , placeholderImage: UIImage(named: "placeholder") )
        }
        
        if let price = appDetail.price , let curreny = appDetail.currency{
            if price != 0 {
                cell.getButton.setTitle("\(String(price)) \(curreny)", for: .normal)
                cell.hasPrice = true
            }else{
                cell.hasPrice = false
            }
        }
//        if let layout = collectionView.collectionViewLayout as? AppDetailFlowLayout {
//            print("done")
//            cell.layoutIfNeeded()
//            let estimatedSize = cell.systemLayoutSizeFitting(CGSize(width: view.frame.width, height: 1000))
//            layout.cellHeaight = estimatedSize.height
//        }
        return cell
    }
    
}