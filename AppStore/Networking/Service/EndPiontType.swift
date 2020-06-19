//
//  EndPiontType.swift
//  NetworkLayer(predefinedCases)
//
//  Created by Ahmad Khalil on 6/17/20.
//  Copyright © 2020 Ahmad Khalil. All rights reserved.
//

import Foundation


protocol EndPiontType {
    var baseUrl : URL { get }
    var path : String { get }
//    var prams : Parameters? { get }
    var task: HTTPTask { get }
    var HttpMethod : String { get }
}

