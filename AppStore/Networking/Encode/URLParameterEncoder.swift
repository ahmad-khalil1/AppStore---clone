//
//  URLParameterEncoder.swift
//  NetworkLayer(predefinedCases)
//
//  Created by Ahmad Khalil on 6/17/20.
//  Copyright © 2020 Ahmad Khalil. All rights reserved.
//

import Foundation

public struct URLParameterEncoder : PrameterEncoder {
    
    public func encode(request: inout URLRequest, with prams: Parameters) throws {
        guard let url = request.url else { return }
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !prams.isEmpty {
            var quiryItems = [URLQueryItem]()
            for (key,value) in prams{
                quiryItems.append(URLQueryItem(name: key, value: value))
            }
            urlComponents.queryItems = quiryItems
            request.url = urlComponents.url
        }
        
    }
}
