//
//  AppsFeedEndPiont.swift
//  NetworkLayer(predefinedCases)
//
//  Created by Ahmad Khalil on 6/19/20.
//  Copyright © 2020 Ahmad Khalil. All rights reserved.
//

import Foundation

public enum AppsFeedEndPiont {
    case appsFeed(appGroup : String )
}

extension AppsFeedEndPiont : EndPiontType {
    var baseUrl: URL {
        guard let url = URL(string: "https://rss.itunes.apple.com") else  { fatalError("baseURL of appsFeed could not be configured.") }
        return url
    }
    
    var path: String {
        switch self {
        case .appsFeed(let appGroup):
            return "api/v1/us/ios-apps/\(appGroup)/all/10/explicit.json"
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .appsFeed :
            return .request
        }
    }
    
    var HttpMethod: String {
        return "GET"
    }
    
     
}
