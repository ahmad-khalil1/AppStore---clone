//
//  AppSearchEndPiont.swift
//  NetworkLayer(predefinedCases)
//
//  Created by Ahmad Khalil on 6/18/20.
//  Copyright © 2020 Ahmad Khalil. All rights reserved.
//

import Foundation

public enum AppSearchEndPiont {
    case appSearchWithTerm(term : String , limit : String = "10" , media : String = "software")
}
extension AppSearchEndPiont : EndPiontType {
    var baseUrl: URL {
        guard let url = URL(string: "https://itunes.apple.com") else { fatalError("baseURL could not be configured.") }
        return url
    }   
    
    var path: String {
        return "search"
    }
    
    
    var task: HTTPTask {
        switch self {
        case .appSearchWithTerm(let term , let limit  , let media):
            return .requestPrameters(urlPrameter: ["term" : term , "limit" : limit , "media" : media ], prameterEncoding: .UrlEncoding)
        }
    }
    
    var HttpMethod: String {
        return "GET"
    }
    
    
    
    
}
