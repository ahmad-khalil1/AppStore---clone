//
//  appRatingsAndReviewsModels.swift
//  AppStore
//
//  Created by Ahmad Khalil on 7/5/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import Foundation

struct AppReviewsFeed : Codable {
    var feed             : AppReviewGroup
}

struct AppReviewGroup : Codable {
    var entry            : [AppReviewEntry]
}

struct AppReviewEntry : Codable {
    
    var authorNameLabel   : String
    var titleLabel        : String
    var contentLabel      : String
    var ratingLabel       : String
    
    //---------------------------------------------
    // Main Root
    enum CodingKeys : String , CodingKey   {
        case author = "author"
        case title = "title"
        case content = "content"
        case rating = "im:rating"
    }
    //---------------------------------------------
    // Container in Container 
    enum AuthorCodingkeys : String , CodingKey {
        case name = "name"
    }
    
    enum AuthorNameCodingkeys : String , CodingKey {
        case authorNameLabel = "label"
    }
    //---------------------------------------------

    enum TitleCodingKeys : String , CodingKey {
        case titleLabel = "label"
    }
    //---------------------------------------------

    enum ContentCodingKey : String , CodingKey {
        case contentLabel = "label"
    }
    //---------------------------------------------
    enum ratingCodingKey : String , CodingKey {
        case ratingLabel  = "label"
    }
    //---------------------------------------------

    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self )
        
        let title = try container.nestedContainer(keyedBy: TitleCodingKeys.self, forKey: .title)
        titleLabel = try title.decode(String.self, forKey: .titleLabel)
        
        let content = try container.nestedContainer(keyedBy: ContentCodingKey.self, forKey: .content)
        contentLabel = try content.decode(String.self, forKey: .contentLabel)
        
        let rating = try container.nestedContainer(keyedBy: ratingCodingKey.self, forKey: .rating)
        ratingLabel = try rating.decode(String.self, forKey: .ratingLabel)
        
        let authorContainer = try container.nestedContainer(keyedBy: AuthorCodingkeys.self, forKey: .author)
        let author = try authorContainer.nestedContainer(keyedBy: AuthorNameCodingkeys.self, forKey: .name)
        authorNameLabel = try author.decode(String.self, forKey: .authorNameLabel)
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self )
        
        var title = container.nestedContainer(keyedBy: TitleCodingKeys.self, forKey: .title)
        try title.encode(titleLabel, forKey: .titleLabel)
        
        var content = container.nestedContainer(keyedBy: ContentCodingKey.self, forKey: .content)
        try content.encode(contentLabel, forKey: .contentLabel)
        
        var rating = container.nestedContainer(keyedBy: ratingCodingKey.self, forKey: .rating)
        try rating.encode(ratingLabel, forKey: .ratingLabel)
        
        var authorContainer = container.nestedContainer(keyedBy: AuthorCodingkeys.self, forKey: .author)
        var author = authorContainer.nestedContainer(keyedBy: AuthorNameCodingkeys.self, forKey: .name)
        try author.encode(authorNameLabel, forKey: .authorNameLabel)
    }
}
