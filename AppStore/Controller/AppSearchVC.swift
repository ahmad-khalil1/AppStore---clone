//
//  AppSearchVC.swift
//  AppStore
//
//  Created by ahmad$$ on 2/14/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit
import SDWebImage


class AppSearchVC: UIViewController{
    
    //MARK:- VC Properties and objects.
    
    var searchController                                           = UISearchController()
    let networkManager                                             = NetworkManager()
    var searchAbleItems                                            = [appResult]()
    let cellId                                                     = "cellid"
    
    //MARK:- UI Elements.
    
    let collectionView : UICollectionView = {
        
        let layout = ColumnFlowLayout()
        let collection                                             = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        
        layout.scrollDirection                                     = .vertical
        collection.backgroundColor                                 = .white
        collection.isScrollEnabled                                 = true
        collection.translatesAutoresizingMaskIntoConstraints       = false
        
        return collection
    }()
    
    let termsFailslabel : UILabel = {
        let label                                                  = UILabel()
        label.text                                                 = "No Results For \n"
        label.numberOfLines                                        = 0
        label.textAlignment                                        = .center
        label.font                                                 = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    //MARK:- Setting up the UI elemnts Position.
    
    func setupCollectionViewCOnstrains(){
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive         = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive   = true
        collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive       = true
        collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive     = true
        
        collectionView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive   = true
        collectionView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive     = true
    }
    
    
    //MARK:- View Life Cycle.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ConfigureCollectionView()
        
        navigationItem.searchController                           = searchController
        navigationItem.hidesSearchBarWhenScrolling                = false
        
        configureSearchController()
        
        view.addSubview(collectionView)
        setupCollectionViewCOnstrains()
    }
    
    fileprivate func configureSearchController() {
        searchController.obscuresBackgroundDuringPresentation     = false
        searchController.searchResultsUpdater                     = self
        searchController.searchBar.delegate                       = self
        searchController.searchBar.placeholder                    = "Apps, Games and More"
    }
    
    fileprivate func ConfigureCollectionView() {
        collectionView.delegate                                   = self
        collectionView.dataSource                                 = self
        collectionView.register(CustomViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
}
//MARK:- collectionView DataSource and Delegate Methods.


extension AppSearchVC : UICollectionViewDataSource , UICollectionViewDelegate  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchAbleItems.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomViewCell
        cell.backgroundColor          = .white
        cell.titleLabel.text          = searchAbleItems[indexPath.row].trackName
        cell.categoryLabel.text       = searchAbleItems[indexPath.row].primaryGenreName
        if let rating                 = searchAbleItems[indexPath.row].averageUserRating{
            cell.ratingLabel.text     = String( rating )
        }
        setImageFromUrlTakingIndex(cell, indexPath)
        
        return cell
    }
    
    fileprivate func setImageFromUrlTakingIndex(_ cell: CustomViewCell, _ indexPath: IndexPath) {
        if let iconImageUrl = searchAbleItems[indexPath.row].artworkUrl512 {
            cell.iconImage.sd_setImage(with: URL(string: iconImageUrl) , placeholderImage: UIImage(named: "placeholder") )
        }
        if let screnShotUrlArray = searchAbleItems[indexPath.row].screenshotUrls {
            cell.appImages.sd_setImage(with: URL(string:screnShotUrlArray[0] ), placeholderImage: UIImage(named: "placeholder"))
            if screnShotUrlArray.count > 2 {
                cell.appImages1.sd_setImage(with: URL(string: screnShotUrlArray[1]), placeholderImage: UIImage(named: "placeholder"))
                cell.appImages2.sd_setImage(with: URL(string: screnShotUrlArray[2]), placeholderImage: UIImage(named: "placeholder"))
            }
        }
    }    
}

//MARK:- SearchController ResultUpdating Methods.

extension AppSearchVC : UISearchResultsUpdating , UISearchBarDelegate {
    
    // responsable for take action when text change
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            
            searchApps(searchText)
            searchBar.resignFirstResponder()
        }
        
    }
    
    
    fileprivate func searchApps(_ searchText: String) {
        networkManager.getAppsSearched(with: searchText) { (appResults, error) in
            if let appResults = appResults {
                self.searchAbleItems = appResults.results
                DispatchQueue.main.async {
                    self.collectionView.backgroundView = nil
                    self.collectionView.reloadData()
                }
            }else {
                self.searchAbleItems.removeAll()
                DispatchQueue.main.async {
                    self.termsFailslabel.text!                          = "No Results For \n"
                    self.termsFailslabel.text!                         += searchText
                    self.collectionView.backgroundView                  = self.termsFailslabel
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
}


// if let termQuered = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
//print(termQuered)
//}


    


