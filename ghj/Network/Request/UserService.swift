//
//  JobSearchService.swift
//  ghj
//
//  Created by Augusto Falcão on 11/11/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

import Foundation

enum UserService: ServiceRequest {
    case getJobList(_:String?, _:String?)

    var path: String {
        switch self {
        case let .getJobList(description, location):
            return "/positions.json?description=\(TextFormater.transformation(text: description ?? ""))&location=\(TextFormater.transformation(text: location ?? ""))"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getJobList(_, _):
            return .get
        }
    }

    var body: Data? {
        switch self {
        case .getJobList(_, _):
            return nil
        }
    }

    var header: [String : String]? {
        switch self {
        case .getJobList(_, _):
            return nil
        }
    }

    var dataType: ResponseType {
        switch self {
        case .getJobList(_, _):
            return .json
        }
    }
}
