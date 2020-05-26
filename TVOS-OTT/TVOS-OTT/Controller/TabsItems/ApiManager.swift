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
            return "/5e4592e9d18e4016617819ff"
        }
        //return Constants.Holder.path
    }
}
