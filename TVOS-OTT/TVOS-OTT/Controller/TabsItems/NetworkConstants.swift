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
    static var movies250: String = "Top250Movies"
    static var tvshow250: String = "Top250TVs"
    static var searchAll: String = "SearchAll"
    static var expression: String = ""
    static var noImageUrl: String = "https://imdb-api.com/images/original/nopicture.jpg"
}
