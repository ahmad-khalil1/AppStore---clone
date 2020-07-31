//
//  AppsHorizontalController.swift
//  AppStore
//
//  Created by ahmad$$ on 2/27/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit
import SDWebImage

class AppsHorizontalController: UIViewController  {
    
    //MARK:- VC Properties and objects.

    var apps = [App]()
    let cellId                                                     = "cellid"

    //MARK:- UI Elements.

    let collectionView : UICollectionView = {
        
        let layout = GridFlowLayout()
        layout.scrollDirection                                     = .horizontal
        let collection                                             = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        
        collection.backgroundColor                                 = .none
        collection.isScrollEnabled                                 = true
        collection.translatesAutoresizingMaskIntoConstraints       = false
        
        return collection
    }()
    
    //MARK:- Setting up the UI elemnts Position.
    
    fileprivate func addingUIElemntsTotheView() {
    view.addSubview(collectionView)

    }

    func setupCnstrains(){
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor ,constant: 12 ).isActive         = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor ,constant:  -12 ).isActive   = true
        collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor , constant: 15 ).isActive       = true
        collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive     = true
        
        //         collectionView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive   = true
        //         collectionView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive     = true
        
    }
    
    //MARK:- View Life Cycle.

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        //let appsVc = AppsVC()
        
        //appsVc.delegate = self
        
        collectionView.dataSource = self
        collectionView.register(customHorizontalCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
        addingUIElemntsTotheView()
        setupCnstrains()
    }

    
//    func termForCell(term: String) {
//        getRequest(term: term)
//
//    }
}

extension AppsHorizontalController : UICollectionViewDataSource , UICollectionViewDelegate  {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apps.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! customHorizontalCollectionViewCell
        cell.titleLabel.text             = apps[indexPath.row].name
        cell.categoryLabel.text          = apps[indexPath.row].artistName
        if let url = apps[indexPath.row].artworkUrl100{
        cell.iconImage.sd_setImage(with: URL(string: url  ), placeholderImage: UIImage(named: "placeholder" ))
        }
        //print("\(appGroup.appGroupArray.count)" + "      appHorizontal cell")
        //cell.backgroundColor = .blue
        return cell
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        let availabelWidth = view.bounds.inset(by: view.layoutMargins).width
    //        return CGSize(width: availabelWidth , height: 230)
    //    }
}



//extension AppsHorizontalController {
//
//
//    func getRequest(term : String){
//
//
//        let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/ios-apps/\(term)/all/10/explicit.json")
//        print(url)
//
//        let session              = URLSession.shared
//        let task                 = session.dataTask(with: url!){ data , response , error in
//            if error != nil || data == nil {
//                print("client error")
//                return
//            }
//            guard let response   = response as? HTTPURLResponse , (200...299).contains(response.statusCode) else {
//                print("server error")
//                return
//            }
//            //            guard let mime = response.mimeType, mime == "application/json" else {
//            //                print("Wrong MIME type!")
//            //                return
//            //            }
//
//            //            do {
//            //                let json = try JSONSerialization.jsonObject(with: data!, options:[])
//            //                print(json)
//            //            }catch{
//            //                print("JSON error: \(error.localizedDescription)")
//            //            }
//            print(data)
//            self.parseJSON(json: data!)
//
//        }
//
//
//
//        task.resume()
//    }
//
//    func parseJSON(json : Data){
//
//        let decoder = JSONDecoder()
//        do{
//            let parsedData = try decoder.decode(appsFeed.self, from: json)
//            //if !parsedData.results.isEmpty {
//            print(parsedData.feed.results[0].name + "----------" + parsedData.feed.results[1].name)
//
//            apps = parsedData.feed.results
////            appGroup.appGroupArray = apps
////            print("\(appGroup.appGroupArray.count)" + "      pars printing")
//
//            DispatchQueue.main.async {
//
//                self.collectionView.backgroundView = nil
//                self.collectionView.reloadData()
//            }
//            //}else {
//            //self.searchAbleItems.removeAll()
//                //DispatchQueue.main.async {
//                  //  self.collectionView.reloadData()
//                    //if let searchBarText = self.searchController.searchBar.text {
//                      //  self.termsFailslabel.text!                                += "\(searchBarText)"
//                    //}
//                    //self.collectionView.backgroundView                  = self.termsFailslabel
//                    //                    self.collectionView.isHidden                   = true
//                    //                    self.termsFailslabel.isHidden                  = false
//                    // self.collectionView.backgroundView = label
//                    //self.collectionView.reloadData()
//
//               // } }
//
//
//        }catch{
//            print("\(error)")
//        }
//
//    }
//}
