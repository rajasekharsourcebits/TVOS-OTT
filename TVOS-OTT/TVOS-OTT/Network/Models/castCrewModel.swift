//
//  castCrewModel.swift
//  TVOS-OTT
//
//  Created by Souvik on 15/06/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct castCrewModel: Codable {
    let id, name: String?
    let role: String?
    let image: String?
    let summary, birthDate: String?
    let deathDate: String?
    let awards, height: String?
    let knownFors: [Similar]?
    let castMovies: [CastMovie]?
    let errorMessage: String?
}

// MARK: - CastMovie
struct CastMovie: Codable {
    let id: String?
    let role: String?
    let title, year, description: String?
}

//enum Role: String, Codable {
//    case actor = "Actor"
//    case archiveFootage = "Archive footage"
//    case roleSelf = "Self"
//    case thanks = "Thanks"
//}
