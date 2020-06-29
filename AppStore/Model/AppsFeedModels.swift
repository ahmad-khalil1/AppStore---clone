//
//  AppsFeedModels.swift
//  NetworkLayer(predefinedCases)
//
//  Created by Ahmad Khalil on 6/19/20.
//  Copyright © 2020 Ahmad Khalil. All rights reserved.
//

import Foundation

struct AppsFeed : Codable {
    var feed                : AppGroup
}

struct  AppGroup : Codable {
    var title               : String
    var results             : [App]?
}

struct App : Codable  {
    var name                : String?
    var artistName          : String?
    var artistId            : String?
    var artworkUrl100       : String?
    var id                  : String?
}

struct headerApp : Codable {
    var name                : String?
    var imageUrl            : String?
    var tagline             : String?
}
