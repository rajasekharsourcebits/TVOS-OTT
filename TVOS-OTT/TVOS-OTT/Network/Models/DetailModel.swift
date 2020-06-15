//
//  DetailModel.swift
//  TVOS-OTT
//
//  Created by Souvik on 15/06/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct DetailsModel: Codable {
    let id, title, originalTitle, fullTitle: String?
    let type, year: String?
    let image: String?
    let releaseDate, runtimeMins, runtimeStr, plot: String?
    let plotLocal: String?
    let plotLocalIsRTL: Bool?
    let awards, directors: String?
    let directorList: [CompanyListElement]?
    let writers: String?
    let writerList: [CompanyListElement]?
    let stars: String?
    let starList: [CompanyListElement]?
    let actorList: [ActorList]?
    let genres: String?
    let genreList: [CountryListElement]?
    let companies: String?
    let companyList: [CompanyListElement]?
    let countries: String?
    let countryList: [CountryListElement]?
    let languages: String?
    let languageList: [CountryListElement]?
    let contentRating, imDBRating, imDBRatingVotes, metacriticRating: String?
    let ratings, wikipedia, posters, images: String?
    //let trailer: JSONNull?
    let boxOffice: BoxOffice?
    let tagline, keywords: String?
    let keywordList: [String]?
    let similars: [Similar]?
    //let tvSeriesInfo, tvEpisodeInfo: JSONNull?
    let errorMessage: String?
}

// MARK: - ActorList
struct ActorList: Codable {
    let id: String?
    let image: String?
    let name, asCharacter: String?
}

// MARK: - BoxOffice
struct BoxOffice: Codable {
    let budget, openingWeekendUSA, grossUSA, cumulativeWorldwideGross: String?
}

// MARK: - CompanyListElement
struct CompanyListElement: Codable {
    let id, name: String?
}

// MARK: - CountryListElement
struct CountryListElement: Codable {
    let key, value: String?
}

// MARK: - Similar
struct Similar: Codable {
    let id, title, fullTitle, year: String?
    let image: String?
    let plot, directors, stars, genres: String?
    let imDBRating: String?
}
