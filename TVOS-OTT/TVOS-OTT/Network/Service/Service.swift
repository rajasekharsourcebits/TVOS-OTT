//
//  Service.swift
//  sampleOTT
//
//  Created by Souvik on 10/05/20.
//  Copyright © 2020 Souvik. All rights reserved.
//

import Foundation

enum ServiceMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
    // implement more when needed.
}

protocol Service {
    var baseUrl: String { get }
    var path: String { get }
    var parameters: [String: Any]? { get }
    var method: ServiceMethod { get }
}

extension Service {
    public var urlRequest: URLRequest {
        
        guard let url = self.url else {
            fatalError("URL could not be built")
        }
        var request = URLRequest(url: url)
        
        request.httpMethod = method.rawValue
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    private var url: URL? {
        let url = URL(string: "\(baseUrl)\(path)")
        return url
    }
}
