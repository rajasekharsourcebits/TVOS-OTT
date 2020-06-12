//
//  CommonVCModel.swift
//  TVOS-OTT
//
//  Created by Kiran on 11/06/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import Foundation

// MARK: - ResultMovies
class HomeResult: Codable {
    let items: [ListItems]?
    let errorMessage: String?
}

// MARK: - Item
class ListItems: Codable {
    let id, rank, title, fullTitle: String?
    let year: String?
    let image: String?
    let crew, imDBRating, imDBRatingCount: String?
}
