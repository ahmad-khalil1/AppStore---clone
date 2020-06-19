//
//  AppGroub.swift
//  AppStore
//
//  Created by ahmad$$ on 2/29/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import Foundation
//
//class AppGroup : NSObject {
//    var name : String?
//    var apps : [App]?
//
//
//     static func fetchAppsGroups(completionHandler: @escaping ([AppGroup])->()){
//
//        var termArray = ["new-apps-we-love","new-games-we-love","top-free"]
//        var appCategories  =  [AppGroup]()
//        for term in termArray {
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
//            parseJSON(json: data!)
//
//            if term == "top-free" {
//                DispatchQueue.main.async {
//                    completionHandler(appCategories)
//                    print ("handler excuted")
//                }
//            }
//        }.resume()
//
//        }
//        func parseJSON(json : Data){
//
//            let decoder = JSONDecoder()
//            let appcatogery = AppGroup()
//            do{
//                let parsedData = try decoder.decode(appsFeed.self, from: json)
//                //if !parsedData.results.isEmpty {
//                print(parsedData)
//
//                appcatogery.name = parsedData.feed.title
//                var appsArray = [App]()
//                for i in 0..<parsedData.feed.results.count{
//                    let app = App()
//                    app.name =   parsedData.feed.results[i].name
//                    app.artistName =  parsedData.feed.results[i].artistName
//                    app.artistId = parsedData.feed.results[i].artistId
//                    app.artworkUrl100 = parsedData.feed.results[i].artworkUrl100
//                    appsArray.append(app)
//                    print ("\(i)"  + "- appObject \(app.name)  " + " {{\(appcatogery.apps?[i].name)}}"   + "  parsed --> \(parsedData.feed.results[i].name)" )
//                }
//                appcatogery.apps = appsArray
//                appCategories.append(appcatogery)
//                print(appcatogery.apps?[0].name)
//                appsArray.removeAll()
//
//                //            appGroup.appGroupArray = apps
//                //            print("\(appGroup.appGroupArray.count)" + "      pars printing")
//
////                DispatchQueue.main.async {
////
////                    self.collectionView.backgroundView = nil
////                    self.collectionView.reloadData()
////                }
//                //}else {
//                //self.searchAbleItems.removeAll()
//                //DispatchQueue.main.async {
//                //  self.collectionView.reloadData()
//                //if let searchBarText = self.searchController.searchBar.text {
//                //  self.termsFailslabel.text!                                += "\(searchBarText)"
//                //}
//                //self.collectionView.backgroundView                  = self.termsFailslabel
//                //                    self.collectionView.isHidden                   = true
//                //                    self.termsFailslabel.isHidden                  = false
//                // self.collectionView.backgroundView = label
//                //self.collectionView.reloadData()
//
//                // } }
//
//
//            }catch{
//                print("\(error)")
//            }
//
//        }
//
//    }
//
//    static func sampleAppGroup() -> [AppGroup] {
//        let newAppsWeloveGroup = AppGroup()
//        newAppsWeloveGroup.name = " New Apps We Love "
//        var NewAppsWeLoveArray = [App]()
//
//        // Logic
//        let hboApp = App()
//        hboApp.name = "HBO"
//        hboApp.artistName  =  "HBO Company"
//        NewAppsWeLoveArray.append(hboApp)
//
//        newAppsWeloveGroup.apps = NewAppsWeLoveArray
//
//        let newGamesWeLoveGroup = AppGroup()
//        newGamesWeLoveGroup.name = " New Games We Love "
//        var newGamesWeLoveArray = [App]()
//        let frozenApp = App()
//        frozenApp.name = "Frozen"
//        frozenApp.artistName  =  "Entertainment"
//        newGamesWeLoveArray.append(frozenApp)
//        newGamesWeLoveGroup.apps = newGamesWeLoveArray
//
//        let bestNewGamesWeLoveGroup = AppGroup()
//        bestNewGamesWeLoveGroup.name = " Best New Games We Love "
//        var BesNewGamesWeLoveArray = [App]()
//        let dolphinApp = App()
//        dolphinApp.name = "Frozen"
//        dolphinApp.artistName  =  "Entertainment"
//        BesNewGamesWeLoveArray.append(frozenApp)
//        bestNewGamesWeLoveGroup.apps = BesNewGamesWeLoveArray
//
//
//        return [newAppsWeloveGroup , newGamesWeLoveGroup , bestNewGamesWeLoveGroup]
//    }
//
//}
//class App: NSObject {
//    var name                : String?
//    var artistName          : String?
//    var artistId            : String?
//    var artworkUrl100       : String?
//}
