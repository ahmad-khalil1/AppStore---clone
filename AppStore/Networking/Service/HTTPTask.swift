//
//  HTTPTask.swift
//  NetworkLayer(predefinedCases)
//
//  Created by Ahmad Khalil on 6/18/20.
//  Copyright © 2020 Ahmad Khalil. All rights reserved.
//

import Foundation

public enum HTTPTask {
    case request
    case requestPrameters(urlPrameter : Parameters? , prameterEncoding : ParameterEncoding)
}
