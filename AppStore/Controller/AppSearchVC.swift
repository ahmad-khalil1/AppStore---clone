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
    
    var searchController                                           = UISearchController()
 
    var searchAbleItems                                            = [appResult]()
    let cellId                                                     = "cellid"
    
    //MARK:- UI CollectionView Configration
    
    let collectionView : UICollectionView = {
        
        let layout = ColumnFlowLayout()
        layout.scrollDirection                                     = .vertical
        let collection                                             = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        
        collection.backgroundColor                                 = .white
        collection.isScrollEnabled                                 = true
        collection.translatesAutoresizingMaskIntoConstraints       = false
        
        return collection
    }()
    
    let termsFailslabel : UILabel = {
        let label                                                  = UILabel()
        label.text                                                 = "No Results \n"
        label.textAlignment                                        = .center
        label.font                                                 = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    func setupCollectionViewCOnstrains(){
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive         = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive   = true
        collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive       = true
        collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive     = true
        
        collectionView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive   = true
        collectionView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive     = true
        
        //        termsFailslabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        //        termsFailslabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        //        termsFailslabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive   = true
        //        termsFailslabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        //        termsFailslabel.heightAnchor.constraint(equalToConstant: 150).isActive = true
        //        termsFailslabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        
        
    }
    
    
    //MARK:- viewDidLoad Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //getRequest(term: "instegram")
        
        collectionView.delegate                                   = self
        collectionView.dataSource                                 = self
        //collectionView.backgroundView                             = termsFailslabel
        //collectionView.addSubview(termsFailslabel)
        collectionView.register(CustomViewCell.self, forCellWithReuseIdentifier: cellId)
        
        navigationItem.searchController                           = searchController
        navigationItem.hidesSearchBarWhenScrolling                = false
        
        searchController.obscuresBackgroundDuringPresentation     = false
        searchController.searchResultsUpdater                     = self
        searchController.searchBar.delegate                       = self
        searchController.searchBar.placeholder                    = "Apps, Games and More"
        
        //termsFailslabel.isHidden = true
        //view.addSubview(termsFailslabel)
        view.addSubview(collectionView)
        setupCollectionViewCOnstrains()
    }
    
}
//MARK:- collectionView DataSource Methods


extension AppSearchVC : UICollectionViewDataSource , UICollectionViewDelegate  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchAbleItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomViewCell
        cell.backgroundColor          = .white
        cell.titleLabel.text          = searchAbleItems[indexPath.row].trackName
        cell.categoryLabel.text       = searchAbleItems[indexPath.row].primaryGenreName
        cell.ratingLabel.text         = String( searchAbleItems[indexPath.row].averageUserRating )
        cell.iconImage.sd_setImage(with: URL(string: searchAbleItems[indexPath.row].artworkUrl512) , placeholderImage: UIImage(named: "placeholder") )
        cell.appImages.sd_setImage(with: URL(string: searchAbleItems[indexPath.row].screenshotUrls[0]), placeholderImage: UIImage(named: "placeholder"))
        
        if searchAbleItems[indexPath.row].screenshotUrls.count > 1 {
            
            cell.appImages1.sd_setImage(with: URL(string: searchAbleItems[indexPath.row].screenshotUrls[1]), placeholderImage: UIImage(named: "placeholder"))
            cell.appImages2.sd_setImage(with: URL(string: searchAbleItems[indexPath.row].screenshotUrls[2]), placeholderImage: UIImage(named: "placeholder"))
            
        }
        
        
        return cell
    }
    
    
    
    func getRequest(term : String){
        
        //var term = "facebook"
        var limit                = "10"
        var media                = "software"
        var quiringItems         = [URLQueryItem]()
        
        let params               = ["term" : term , "limit" : limit , "media" : media ]
        var urlComponant         = URLComponents(string: "https://itunes.apple.com/search?")!
        for (key,value) in params {
            quiringItems.append(URLQueryItem(name: key, value: value))
        }
        urlComponant.queryItems  = quiringItems
        print( urlComponant.url!)
        
        let session              = URLSession.shared
        let task                 = session.dataTask(with: urlComponant.url!){ data , response , error in
            if error != nil || data == nil {
                print("client error")
                return
            }
            guard let response   = response as? HTTPURLResponse , (200...299).contains(response.statusCode) else {
                print("server error")
                return
            }
            //            guard let mime = response.mimeType, mime == "application/json" else {
            //                print("Wrong MIME type!")
            //                return
            //            }
            
            //            do {
            //                let json = try JSONSerialization.jsonObject(with: data!, options:[])
            //                print(json)
            //            }catch{
            //                print("JSON error: \(error.localizedDescription)")
            //            }
            self.parseJSON(json: data!)
            
        }
        
        
        
        task.resume()
    }
    
    func parseJSON(json : Data){
        
        let decoder = JSONDecoder()
        do{
            let parsedData = try decoder.decode(appSearchResults.self, from: json)
            if !parsedData.results.isEmpty {
                print(parsedData.results[0].trackName + "----------" + parsedData.results[1].trackName)
                
                searchAbleItems = parsedData.results
                
                DispatchQueue.main.async {
                    self.collectionView.backgroundView = nil
                    self.collectionView.reloadData()
                }
            }else {
                self.searchAbleItems.removeAll()
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    if let searchBarText = self.searchController.searchBar.text {
                        self.termsFailslabel.text!                                += "\(searchBarText)"
                    }
                    self.collectionView.backgroundView                  = self.termsFailslabel
                    //                    self.collectionView.isHidden                   = true
                    //                    self.termsFailslabel.isHidden                  = false
                    // self.collectionView.backgroundView = label
                    //self.collectionView.reloadData()
                    
                }
                
            }
        }catch{
            print("\(error)")
        }
        
    }
    
}

extension AppSearchVC : UISearchResultsUpdating , UISearchBarDelegate {
    
    // responsable for take action when text change
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            // if let termQuered = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            //print(termQuered)
            //}
            getRequest(term: searchText)
            
        }
        searchBar.resignFirstResponder()
    }
    
}



//extension UIImageView {
//    func load(url: URL) {
//        DispatchQueue.global().async { [weak self] in
//            if let data = try? Data(contentsOf: url) {
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        self?.image = image
//                    }
//                }
//            }
//        }
//    }
//}
//
//
    
    


