//
//  NetworkConstants.swift
//  TVOS-OTT
//
//  Created by Souvik on 26/05/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import Foundation

struct Constants {
    //key = k_Q0iHYBj6
    struct Holder {
        
        static var baseUrl: String = "https://imdb-api.com/en/API/"
        
    }
    
    var baseUrl: String {
        get {
            return Holder.baseUrl
        }
    }
}

extension Constants {
    
    static var key: String = "/k_Q0iHYBj6"
    static var mostPopularMovies: String = "MostPopularMovies"
    static var mostPopularTVs: String = "MostPopularTVs"
    static var inTheaters: String = "InTheaters"
    static var comingSoon: String = "ComingSoon"
    static var boxOffice: String = "BoxOffice"
    static var boxOfficeAllTime: String = "BoxOfficeAllTime"
    static var movies250: String = "Top250Movies"
    static var tvshow250: String = "Top250TVs"
    static var searchAll: String = "SearchAll"
    static var expression: String = ""
    static var detail: String = "Title"
    static var noImageUrl: String = "https://imdb-api.com/images/original/nopicture.jpg"
}

