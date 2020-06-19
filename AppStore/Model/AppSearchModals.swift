//
//  AppSearchModals.swift
//  NetworkLayer(predefinedCases)
//
//  Created by Ahmad Khalil on 6/19/20.
//  Copyright © 2020 Ahmad Khalil. All rights reserved.
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
