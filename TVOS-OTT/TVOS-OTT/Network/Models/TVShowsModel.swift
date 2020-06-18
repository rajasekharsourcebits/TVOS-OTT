//
//  TVShowsModel.swift
//  TVOS-OTT
//
//  Created by Kiran on 10/06/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import Foundation

// MARK: - ResultTVShows
class ResultTVShows: Codable {
    let items: [TVShowsItem]?
    let errorMessage: String?
}

// MARK: - Item
class TVShowsItem: Codable {
    let id, rank, title, fullTitle: String?
    let year: String?
    let image: String?
    let crew, imDBRating, imDBRatingCount: String?
}
