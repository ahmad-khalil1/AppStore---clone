//
//  TodayAppListVC.swift
//  AppStore
//
//  Created by Ahmad Khalil on 7/18/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class TodayAppListVC: UICollectionViewController , UICollectionViewDelegateFlowLayout{
    
    var completion : (() -> ())?

    var isCloseButtonHidden : Bool? {
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                
            }
        }
    }
    
    var todayItem : todayItem? {
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        if let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            
            layout.scrollDirection = .vertical
        }
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .white
        collectionView.contentInset = .init(top: 24, left: 0, bottom: 24, right: 0)
        self.collectionView!.register(customHorizontalCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.register(TodayAppListHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")

        // Do any additional setup after loading the view.
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! customHorizontalCollectionViewCell
        if let todayitem = self.todayItem {
            if let app = todayitem.itemAppGroup {
                cell.app = app[indexPath.row]
            }
        }
        return cell
    }
    
   
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! TodayAppListHeader
        if let todayitem = self.todayItem {
            view.todayItem = todayitem
        }
        view.closeButton.addTarget(self, action: #selector(handelCloseButtonClicked), for: .touchUpInside)

        return view
    }
    
    @objc func handelCloseButtonClicked(button : UIButton , gesture : UITapGestureRecognizer? = nil) {
           if let completion  = completion {
               completion()
           }
           
           button.alpha = 0
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 30 , height:  65 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.frame.width  , height:  120 )

    }
    @objc func handleSwipGesture(_ gesture : UISwipeGestureRecognizer ){
        self.navigationController?.popViewController(animated: true)
    }
}

extension TodayAppListVC {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let id = self.todayItem?.itemAppGroup?[indexPath.row].id{
            let appVC = AppDetailVC(id: id)
            //            self.present(appVC, animated: true )
            //            appVC.navigationController?.isNavigationBarHidden = false
            //            appVC.navigationController?.navigationBar.backgroundColor = .none
            //            appVC.navigationController?.navigationBar.shadowImage = UIImage()
            let swipGestureRecognizer : UISwipeGestureRecognizer = {
                let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipGesture))
                gesture.direction = .right
                return gesture
            }()
            appVC.view.addGestureRecognizer(swipGestureRecognizer)
            appVC.view.isUserInteractionEnabled = true
            self.navigationController?.pushViewController(appVC, animated: true)
        }
    }
}

class TodayAppListHeader: UICollectionReusableView {
    
    var todayItem : todayItem? {
        didSet{
            if let todayItem = todayItem {
                listCategoryLabel.text = todayItem.itemTitle
                listTitleLabel.text = todayItem.itemSubtitle
            }
        }
    }
    
    let closeButton : UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(#imageLiteral(resourceName: "closeButton"), for: .normal)
    //        button.backgroundColor = .lightGray
            button.clipsToBounds = true
            return button
        }()
    
       let listCategoryLabel : UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .boldSystemFont(ofSize: 20)
            label.text =  "DAILY LIST"
        
            return label
        }()
        
        let listTitleLabel : UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .boldSystemFont(ofSize: 28)
            label.text =  "Test Drive thes CarPlay apps "
            label.numberOfLines = 2
//            label.backgroundColor  = .lightGray
            return label
        }()
    
    override init(frame: CGRect) {
           super.init(frame:frame)
        addSubview(closeButton)
        addSubview(listCategoryLabel)
        addSubview(listTitleLabel)
        
        
        clipsToBounds = true
        
        closeButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor  ).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor , constant: -5 ).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 38).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
//
        listCategoryLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor  ).isActive = true
        listCategoryLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor , constant: 15 ).isActive = true
        listCategoryLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor , constant: -15 ).isActive = true
        listCategoryLabel.heightAnchor.constraint(equalToConstant: 30 ).isActive = true


        listTitleLabel.topAnchor.constraint(equalTo: listCategoryLabel.bottomAnchor, constant: 10 ).isActive = true
        listTitleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor , constant: 15 ).isActive = true
        listTitleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor , constant: -15 ).isActive = true
        listTitleLabel.heightAnchor.constraint(equalToConstant: 72 ).isActive = true
//        listCategoryLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor  ).isActive = true

        
        
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
}
