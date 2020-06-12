//
//  MoviesModel.swift
//  TVOS-OTT
//
//  Created by Kiran on 10/06/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import Foundation

// MARK: - ResultMovies
class ResultMovies: Codable {
    let items: [MoviesItem]?
    let errorMessage: String?
}

// MARK: - Item
class MoviesItem: Codable {
    let id, rank, title, fullTitle: String?
    let year: String?
    let image: String?
    let crew, imDBRating, imDBRatingCount: String?
}
