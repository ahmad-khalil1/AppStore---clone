//
//  NetworkManager.swift
//  NetworkLayer(predefinedCases)
//
//  Created by Ahmad Khalil on 6/18/20.
//  Copyright © 2020 Ahmad Khalil. All rights reserved.
//

import Foundation

enum NetworkResponse:String {
    case success
    case badConnection = "Please check your network connection "
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}

struct NetworkManager {
    private let appsSearchedRouter = Router<AppSearchEndPiont>()
    private let appsFeedRouter = Router<AppsFeedEndPiont>()
    
    func getAppsSearched(with term : String , completion : @escaping (_ appResult : appSearchResults? , _ error : String? ) -> () ){
        appsSearchedRouter.request(.appSearchWithTerm(term: term, limit: "10", media: "software")) { (data, response, error) in
            if error != nil {
                completion( nil , NetworkResponse.badConnection.rawValue )
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseDate = data else {
                        completion(nil , NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let ParsedData = try JSONDecoder().decode(appSearchResults.self, from: responseDate)
                        completion( ParsedData , nil)
                    }catch {
                        print(error)
                        completion(nil , NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let netowrkFailureError ):
                    completion(nil , netowrkFailureError)
                }
            }
        }
    }
    
    func getAppsFeed(with appGroups : [String] , completion : @escaping (_ appsFeedResults : [AppGroup]? ,_ error : String?  )->() ){
        print(appGroups.count)
        var appGroupArray = [AppGroup]()
        for (index , appGroupName) in appGroups.enumerated() {
            appsFeedRouter.request(.appsFeed(appGroup: appGroupName)) { (data, response, error ) in
                if error != nil {
                    completion( nil , NetworkResponse.badConnection.rawValue )
                }
                if let response = response as? HTTPURLResponse {
                    let result = self.handleNetworkResponse(response)
                    switch result {
                    case .success:
                        guard let responseDate = data else {
                            completion(nil , NetworkResponse.noData.rawValue)
                            return
                        }
                        do{
                            let parsedData = try JSONDecoder().decode(AppsFeed.self, from: responseDate)
                            appGroupArray.append(parsedData.feed)
                            if index == appGroups.count - 1{
                                completion( appGroupArray , nil)
                            }
                            
                        }catch{
                            print(error)
                            completion( nil , NetworkResponse.unableToDecode.rawValue)
                        }
                    case .failure(let netowrkFailureError ):
                        completion(nil , netowrkFailureError)
                    }
                }
            }
        }
    }
    
   fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
           switch response.statusCode {
           case 200...299: return .success
           case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
           case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
           case 600: return .failure(NetworkResponse.outdated.rawValue)
           default: return .failure(NetworkResponse.failed.rawValue)
           }
    }
}
