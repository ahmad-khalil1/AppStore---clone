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
    
    var searchAbleItems = [appResult]()
    let cellId = "cellid"
    
    //MARK:- UI CollectionView Configration
    
    let collectionView : UICollectionView = {

        let layout = ColumnFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        
        collection.backgroundColor = .white
        collection.isScrollEnabled = true
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        return collection
    }()
    
    func setupCollectionViewCOnstrains(){
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        
        collectionView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true

    }
    
    
    //MARK:- viewDidLoad Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRequest()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CustomViewCell.self, forCellWithReuseIdentifier: cellId)

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
        cell.backgroundColor = .white
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
    
    struct appResult : Codable {
        var trackName : String
        var primaryGenreName : String
        var averageUserRating : Double
        var artworkUrl512 : String
        var screenshotUrls : [String]
    }
    
    struct appSearchResults : Codable {
        var results : [appResult]
    }
    
    
    func getRequest(){
        
        var term = "facebook"
        var limit = "10"
        var media = "software"
        var quiringItems = [URLQueryItem]()
        
        let params = ["term" : term , "limit" : limit , "media" : media ]
        let session = URLSession.shared
        var urlComponant = URLComponents(string: "https://itunes.apple.com/search?")!
        for (key,value) in params {
            quiringItems.append(URLQueryItem(name: key, value: value))
        }
        urlComponant.queryItems = quiringItems
        print( urlComponant.url!)
        let task = session.dataTask(with: urlComponant.url!){ data , response , error in
            if error != nil || data == nil {
                print("client error")
                return
            }
            guard let response = response as? HTTPURLResponse , (200...299).contains(response.statusCode) else {
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
            
            print(parsedData.results[0].trackName + "----------" + parsedData.results[1].trackName)
            
            searchAbleItems = parsedData.results
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }catch{
            print("\(error)")
        }
        
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
    
    


