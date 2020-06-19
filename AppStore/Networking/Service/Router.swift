//
//  Router.swift
//  NetworkLayer(predefinedCases)
//
//  Created by Ahmad Khalil on 5/20/20.
//  Copyright © 2020 Ahmad Khalil. All rights reserved.
//

import Foundation


//enum Router {
//
//    //  the requests endpoint you want to send to the API
//
//    case getAppSearch
//    case getAppsFeed
//
//    var schema : String {
//        switch self {
//        case .getAppSearch ,.getAppsFeed :
//            return "https"
//        }
//    }
//
//    var host : String {
//        switch self {
//        case .getAppSearch:
//            return "itunes.apple.com"
//        case .getAppsFeed:
//            return "rss.itunes.apple.com"
//        }
//    }
//    var path : String {
//        switch self {
//        case .getAppSearch :
//            return ""
//        case .getAppsFeed :
//            return ""
//
//        }
//    }
//}

protocol NetworkRouter {
    associatedtype endpoint : EndPiontType
    func request(_ route : endpoint , completion : @escaping (_ data : Data? , _ response : URLResponse? , _ error : Error? )->())
    func cancel ()
}

class Router<endpoint : EndPiontType> : NetworkRouter {
    
    private var task : URLSessionTask?
    func request(_ route: endpoint, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let session = URLSession.shared
        do{
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                completion(data,response,error)
            })
        }catch{
            completion(nil,nil,error)
        }
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    fileprivate func buildRequest(from route : endpoint ) throws -> URLRequest{
        var request = URLRequest(url: route.baseUrl.appendingPathComponent(route.path) )
        request.httpMethod = route.HttpMethod
        do {
            switch route.task {
            case .requestPrameters(let urlPrameter, let prameterEncoding):
                try self.configurepramater(urlPrameter: urlPrameter, prameterEncoding: prameterEncoding, request: &request)
            case .request :
                return request
            }
        }catch{
            throw error
        }
//        print(request.url)
        return request
    }
    
    fileprivate func configurepramater(urlPrameter : Parameters? , prameterEncoding : ParameterEncoding , request : inout URLRequest) throws {
        do{
            try prameterEncoding.encode(urlRequest: &request, UrlParamters: urlPrameter)
        }catch{
            throw error
        }
        
    }
    
    
}
