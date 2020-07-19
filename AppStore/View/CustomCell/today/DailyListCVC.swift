//
//  DailyListCVC.swift
//  AppStore
//
//  Created by Ahmad Khalil on 7/17/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit

class DailyListCVC : TodayBaseCell {
    
    override var todayitem : todayItem? {
          didSet{
              if let todayitem = todayitem {
                  listCategoryLabel.text = todayitem.itemTitle
                  listTitleLabel.text = todayitem.itemSubtitle
                  self.contentView.backgroundColor = todayitem.itemColor
                DispatchQueue.main.async {
                    self.verticalCollectionView.reloadData()
                    
                }
              }
          }
      }
    
    let listCategoryLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.text =  "Daily list"
        
        return label
    }()
    
    let listTitleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 28)
        label.text =  "Test Drive thes CarPlay apps "
        label.numberOfLines = 2
//        label.backgroundColor  = .lightGray
        return label
    }()
    
    let verticalCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame:CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection                               = .vertical
        collection.backgroundColor   = .white
        collection.isScrollEnabled                                 = false
        collection.isUserInteractionEnabled                        = false
        collection.translatesAutoresizingMaskIntoConstraints       = false
        return collection
    }()
    
    let verticalStack : UIStackView = {
        let stack                                         = UIStackView()
        stack.axis                                        = .vertical
        stack.distribution                                = .fill
        stack.spacing                                     = 10
        stack.alignment                                   = .leading
        stack.translatesAutoresizingMaskIntoConstraints   = false
        return stack
    }()
    
    
    fileprivate func addingUIElemntsTotheView() {
        verticalStack.addArrangedSubview(listCategoryLabel)
        verticalStack.addArrangedSubview(listTitleLabel)
        verticalStack.addArrangedSubview(verticalCollectionView)

        addSubview(verticalStack)

    }
    
    fileprivate func setupUIConstrains() {
        
        verticalCollectionView.leadingAnchor.constraint(equalTo: verticalStack.leadingAnchor).isActive = true
        verticalCollectionView.trailingAnchor.constraint(equalTo: verticalStack.trailingAnchor).isActive = true
        
        
        listCategoryLabel.heightAnchor.constraint(equalToConstant: 30 ).isActive = true
        verticalCollectionView.heightAnchor.constraint(equalToConstant: 310 ).isActive = true
        
        verticalStack.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor , constant:  24).isActive = true
        verticalStack.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor , constant:  24).isActive = true
        verticalStack.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor , constant:  -24).isActive = true
        verticalStack.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor , constant:  -24).isActive = true
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
         
        
        verticalCollectionView.dataSource = self
        verticalCollectionView.delegate   = self
    
        verticalCollectionView.register(customHorizontalCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        verticalCollectionView.reloadData()
        
       
        
        addingUIElemntsTotheView()
        setupUIConstrains()
        
   
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DailyListCVC : UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! customHorizontalCollectionViewCell
        
        if let todayitem = self.todayitem {
            if let app = todayitem.itemAppGroup {
                cell.app = app[indexPath.row]
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//         print("/n \(((collectionView.frame.height) / 4 ) - 8 ) /n")
        return CGSize(width: collectionView.frame.width, height:  70 )

    }
    
}

class listCVC: UICollectionViewCell {
    
      fileprivate func addingUIElemntsTotheView() {
      
      }
      
      fileprivate func setupUIConstrains() {
        
          
      }
      
      override init(frame: CGRect) {
          super.init(frame: frame)
          contentView.backgroundColor = .lightGray
          
          addingUIElemntsTotheView()
          setupUIConstrains()
          
      }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
}


//
//print(self.verticalStack.frame)
//print(self.verticalCollectionView.frame)
//print(self.verticalCollectionView.cellForItem(at: [1])?.frame)
//print(self.listCategoryLabel.frame)
//print(self.listTitleLabel.frame)
