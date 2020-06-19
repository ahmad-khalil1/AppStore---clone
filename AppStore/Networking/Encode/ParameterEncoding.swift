//
//  ParameterEncoding.swift
//  NetworkLayer(predefinedCases)
//
//  Created by Ahmad Khalil on 6/17/20.
//  Copyright © 2020 Ahmad Khalil. All rights reserved.
//

import Foundation

public typealias Parameters = [String:String]

public protocol PrameterEncoder {
    func encode(request: inout URLRequest , with prams : Parameters) throws
}

public enum ParameterEncoding {
    case UrlEncoding
    
    public func encode(urlRequest : inout URLRequest , UrlParamters : Parameters?) throws {
        do {
            switch self {
            case .UrlEncoding :
                guard let urlPrameters = UrlParamters else {return}
                try URLParameterEncoder().encode(request: &urlRequest , with : urlPrameters )
            }
        }catch {
            throw error
        }
    }
}

