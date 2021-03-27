//
//  TodayDetailVC.swift
//  AppStore
//
//  Created by Ahmad Khalil on 7/13/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit

class TodayDetailVC : TodayFullScreenBaseVC {
    
    //MARK:- VC Properties and objects.

    let headerCellHeight                   : CGFloat  = 480

    override var isCloseButtonHidden : Bool? {
        didSet{
            self.collectionView.reloadData()
        }
    } 
    override var todayItem : todayItem? {
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    //MARK:- UI Elements.

    fileprivate func configureTableView() {
//        tableView.separatorStyle = .none
        collectionView.backgroundColor = .white
        //        tableView.tableFooterView = UIView()
        collectionView.contentInset = UIEdgeInsets(top: 0 , left: 0, bottom: 20, right: 0)
        collectionView.allowsSelection = false
        collectionView.register(TableCell.self, forCellWithReuseIdentifier: "cellId2")
//        collectionView.register(TodayHeaderCell.self, forCellWithReuseIdentifier: "cellId1")
        self.collectionView.register(TodayHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")

    }

    //MARK:- View Life Cycle.

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Table view data source
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
         
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId2", for: indexPath)
        return  cell
    }
 
    
     override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let cellType = todayItem?.itemCellType else {return UICollectionReusableView()}
        guard let todayItem = todayItem  else {  return UICollectionReusableView()}
        
        switch cellType {
        case .list:
            return configureTodayDeatailHeaderCell(todayItem,DailyListCVC(), indexPath)
        case .today:
            return configureTodayDeatailHeaderCell(todayItem,TodayCVC(), indexPath)
        case .todayMovingIcon:
            return configureTodayDeatailHeaderCell(todayItem,MovingIconCVC(), indexPath)

        }
    }
    
    
     fileprivate func configureTodayDeatailHeaderCell(_ todayItem: todayItem  ,_ baseCell : TodayBaseCell ,_ indexPath : IndexPath ) -> UICollectionReusableView {
         let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! TodayHeaderCell
         cell.todayCell = baseCell
         cell.todayCell!.todayitem = todayItem
         cell.closeButton.addTarget(self, action: #selector(handelCloseButtonClicked), for: .touchUpInside)
         if let isCloseButtonHidden = self.isCloseButtonHidden {
             cell.closeButton.isHidden = isCloseButtonHidden
         }
         cell.todayCell!.contentView.layer.cornerRadius = 0
         return cell
     }
    

    // MARK: - TableView Delegate

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width , height:  460 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return  CGSize(width: collectionView.frame.width , height:  headerCellHeight )
    }
    
}

//MARK:- TableView Regular cell Class

class TableCell : UICollectionViewCell {
    let descriptionLabel : UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "Great games", attributes: [.foregroundColor: UIColor.black])
        
        attributedText.append(NSAttributedString(string: " are all about the details, from subtle visual effects to imaginative art styles. In these titles, you're sure to find something to marvel at, whether you're into fantasy worlds or neon-soaked dartboards.", attributes: [.foregroundColor: UIColor.gray]))
        
        attributedText.append(NSAttributedString(string: "\n\n\nHeroic adventure", attributes: [.foregroundColor: UIColor.black]))
        
        attributedText.append(NSAttributedString(string: "\nBattle in dungeons. Collect treasure. Solve puzzles. Sail to new lands. Oceanhorn lets you do it all in a beautifully detailed world.", attributes: [.foregroundColor: UIColor.gray]))
        
        attributedText.append(NSAttributedString(string: "\n\n\nHeroic adventure", attributes: [.foregroundColor: UIColor.black]))
        
        attributedText.append(NSAttributedString(string: "\nBattle in dungeons. Collect treasure. Solve puzzles. Sail to new lands. Oceanhorn lets you do it all in a beautifully detailed world.", attributes: [.foregroundColor: UIColor.gray]))
        
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.attributedText = attributedText
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate func addingUIElemntsTotheView() {
        addSubview(descriptionLabel)

    }
    
    fileprivate func setupUIConstrains() {
        
        descriptionLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor).isActive             = true
        descriptionLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor , constant: 24  ).isActive    = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor , constant: -24 ).isActive  = true
        //        descriptionLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive       = true
        
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        addingUIElemntsTotheView()
        setupUIConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:- TableView Header cell Class


class TodayHeaderCell : UICollectionReusableView {
    
    var todayCell : TodayBaseCell? {
        didSet{
            addingUIElemntsTotheView()
            setupUIConstrains()
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
    
    fileprivate func addingUIElemntsTotheView() {
        if let todayCell = self.todayCell {
            addSubview(todayCell)
        }
        addSubview(closeButton)
    }
    
    fileprivate func setupUIConstrains() {
        
        
        closeButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor , constant: 30 ).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor , constant: -5 ).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 38).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        if let todayCell = self.todayCell {
            todayCell.translatesAutoresizingMaskIntoConstraints = false
            todayCell.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive            = true
            todayCell.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive    = true
            todayCell.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive  = true
            todayCell.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive      = true
        }
       
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        addingUIElemntsTotheView()
        setupUIConstrains()
    }
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
}


    //    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        return TodayCVC()
    //    }
//
//
//
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 400
//    }
//

//func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//       if indexPath.row == 0 {
//           return  CGSize(width: collectionView.frame.width , height:  headerCellHeight )
//       }
//       return CGSize(width: collectionView.frame.width , height:  460 )
//   }
   
