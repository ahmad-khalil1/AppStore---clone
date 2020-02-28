//
//  DataModel.swift
//  AppStore
//
//  Created by ahmad$$ on 2/27/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import Foundation

struct appResult : Codable {
    var trackName           : String
    var primaryGenreName    : String
    var averageUserRating   : Double
    var artworkUrl512       : String
    var screenshotUrls      : [String]
}

struct appSearchResults : Codable {
    var results             : [appResult]
}
