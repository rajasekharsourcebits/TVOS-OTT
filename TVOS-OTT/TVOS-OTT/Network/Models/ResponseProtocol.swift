//
//  ResponseProtocol.swift
//  TVOS-OTT
//
//  Created by Kiran on 03/06/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import Foundation

/// Response Protocol
protocol ResponseProtocol: Codable {
    var statusCode: Int32 { get set}
    var message: String { get set }
}
