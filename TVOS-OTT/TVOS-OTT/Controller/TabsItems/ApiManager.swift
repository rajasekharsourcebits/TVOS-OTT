//
//  ApiManager.swift
//  TVOS-OTT
//
//  Created by Souvik on 26/05/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import Foundation

enum UserService {
    case top250movies
    case top250tvShow
    case searchAll
}

extension UserService: Service {
    var parameters: [String : Any]? {
        return ["":""]
    }
    
    var method: ServiceMethod {
        return .get
    }
    
    var baseUrl: String {
        return  Constants().baseUrl
    }
    
    var path: String {
        switch self {
        case .top250movies:
            return Constants.movies250 + Constants.key
        case .top250tvShow:
            return Constants.tvshow250 + Constants.key
        case .searchAll:
            return Constants.searchAll + Constants.key
        }
        //return Constants.Holder.path
    }
    
    var expression: String {
        switch self {
        case .top250movies:
            return ""
        case .top250tvShow:
            return ""
        case .searchAll:
            return Constants.expression
        }
    }
}
