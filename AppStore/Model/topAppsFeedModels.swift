//
//  topPaidalternateModel.swift
//  AppStore
//
//  Created by Ahmad Khalil on 3/18/21.
//  Copyright © 2021 ahmad. All rights reserved.
//

import Foundation


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct Apps_feed: Codable {
    var feed: Feed
}

// MARK: - Feed
struct Feed: Codable {
    var title: String
    let entry: [app_]
}


// MARK: - Entry
struct app_: Codable {
    
    let id: String
    let title, summary, name: String
    let artist, price: String
    let image: [String]
    let rights: String
}


