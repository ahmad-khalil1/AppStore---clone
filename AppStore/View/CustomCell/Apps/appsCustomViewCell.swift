//
//  appsCustomViewCell.swift
//  AppStore
//
//  Created by ahmad$$ on 2/27/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit

class appsCustomViewCell: UICollectionViewCell  {
    //MARK:- intializing the UI elemnts
    
    var appCategory : AppGroup? {
        didSet {
            if let name = appCategory?.title {
                titleLabel.text = name
            }
        }   
    }
    let cellId = "cellid"
    var term = ""
    let didselecthandler = ((App) -> ()).self

    
    
    let titleLabel : UILabel = {
     let label =  UILabel()
        label.text = "App Section"
        label.font = .boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let horizontalAppvsCollectionView : UICollectionView =  {
       let layout = GridFlowLayout()
        layout.scrollDirection                                     = .horizontal
        let collection                                             = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collection.contentInset                                    = .init(top: 0, left: 15, bottom: 0, right: 15)
        collection.backgroundColor                                 = .none
        collection.isScrollEnabled                                 = true
        collection.translatesAutoresizingMaskIntoConstraints       = false
        
        return collection
    }()
    
//    let horizontalController = AppsHorizontalController()
    
    
   
        func addingUIElemntsTotheView(){
            addSubview(titleLabel)
            addSubview(horizontalAppvsCollectionView)
        }
        
        func setupUIConstrains(){

            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5 ).isActive              = true
            titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor , constant: 15).isActive      = true
            titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive    = true

            horizontalAppvsCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor , constant: 15 ).isActive = true
            horizontalAppvsCollectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor ).isActive = true
            horizontalAppvsCollectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
            horizontalAppvsCollectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor , constant: -15 ).isActive = true
        }
       
    
    
   
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        horizontalAppvsCollectionView.dataSource = self
        horizontalAppvsCollectionView.delegate   = self
        horizontalAppvsCollectionView.register(customHorizontalCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
//        horizontalController.term = term
        addingUIElemntsTotheView()
        setupUIConstrains()
        //setUp(controller: )
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension appsCustomViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = appCategory?.results?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = horizontalAppvsCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! customHorizontalCollectionViewCell
        if let app = appCategory?.results?[indexPath.row] {
            cell.app = app
            
        }
        return cell
    }
}

extension appsCustomViewCell : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let child  = self.window?.rootViewController?.children
//        if let appsVC = child?[1] {
//            let nC = appsVC.navigationController
//            let vC = UIViewController()
//            vC.view.backgroundColor = .blue
//            nC?.pushViewController(vC, animated: true)
//        }
        if let app = appCategory?.results?[indexPath.row] {
            NotificationCenter.default.post(name: Notification.Name("didSelectAppCell"), object: nil , userInfo: ["app" : app])
            
        }
    }
}
