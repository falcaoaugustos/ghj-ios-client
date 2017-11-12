//
//  ServiceRequest.swift
//  ghj
//
//  Created by Augusto Falcão on 11/11/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

import Foundation

enum ResponseType {
    case json
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol ServiceRequest {
    var path: String { get }
    var method: HTTPMethod { get }
    var body: Data? { get }
    var headers: [[String: String]]? { get }
    var dataType: ResponseType { get }
}

