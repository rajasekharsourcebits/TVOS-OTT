//
//  BannerModel.swift
//  TVOS-OTT
//
//  Created by Kiran on 18/05/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import Foundation

/// Response Protocol
protocol ResponseProtocol: Codable {
    var statusCode: Int32 { get set}
    var message: String { get set }
}
//https://imdb-api.com/en/API/Title/k_Q0iHYBj6/tt1375666
struct ValuationListRequestModel: Codable {
    var makeId: Int32 = 0
    var modelId: Int32 = 0
    var variantId: Int32 = 0
    var year: Int32 = 0
    var pageNumber: Int = 1
    var duration: Int = 1
    var fromDate: Int64 = 0
    var toDate: Int64 = 0
}

struct ValuationListModel: ResponseProtocol {
    var statusCode: Int32
    var message: String
    var responseData: [ValuationListDataModel]?
}

struct ValuationListDataModel: Codable {
    var registrationNumber: String?
    var valuationNumber: String?
    var valuationDate: Int64?
    var valuationId: Int64?
    var year: Int?
    var synched: Bool?
    var title: String?
    var firstName: String?
    var middleName: String?
    var lastName: String?
    var mobileNumber: String?
    var mailId: String?
    var inspectionLevel: Double?
    var rfCost: Double?
    var latestOfferedPrice: Double?
}
