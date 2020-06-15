//
//  ApiManager.swift
//  TVOS-OTT
//
//  Created by Souvik on 26/05/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import Foundation

enum UserService {
    case mostPopularMovies
    case mostPopularTVs
    case inTheaters
    case comingSoon
    case boxOffice
    case boxOfficeAllTime
    case top250movies
    case top250tvShow
    case searchAll
    case DetailsData
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
        case .mostPopularMovies:
            return Constants.mostPopularMovies + Constants.key
        case .mostPopularTVs:
            return Constants.mostPopularTVs + Constants.key
        case .inTheaters:
            return Constants.inTheaters + Constants.key
        case .comingSoon:
            return Constants.comingSoon + Constants.key
        case .boxOffice:
            return Constants.boxOffice + Constants.key
        case .boxOfficeAllTime:
            return Constants.boxOfficeAllTime + Constants.key
        case .top250movies:
            return Constants.movies250 + Constants.key
        case .top250tvShow:
            return Constants.tvshow250 + Constants.key
        case .searchAll:
            return Constants.searchAll + Constants.key
        case .DetailsData:
            return Constants.detail + Constants.key
        }
        //return Constants.Holder.path
    }
    
    var expression: String {
        switch self {
        case .searchAll:
            return Constants.expression
        default:
            return ""
        }
    }
}
