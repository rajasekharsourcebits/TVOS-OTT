//
//  SearchModel.swift
//  TVOS-OTT
//
//  Created by Kiran on 03/06/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import Foundation

// MARK: - ResultSearch
struct ResultSearch: Codable {
    let searchType, expression: String?
    let results: [searchList]?
    let errorMessage: String?
}

// MARK: - Result
struct searchList: Codable {
    let id, resultType: String?
    let image: String?
    let title, resultDescription: String?

    enum CodingKeys: String, CodingKey {
        case id, resultType, image, title
        case resultDescription = "description"
    }
}


