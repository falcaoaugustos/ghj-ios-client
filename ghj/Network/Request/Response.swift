//
//  Response.swift
//  ghj
//
//  Created by Augusto Falcão on 11/13/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

import Foundation

enum ResponseError: Error, LocalizedError {
    case unauthorized
    case internalError

    public var errorDescription: String? {
        switch self {
        case .unauthorized:
            return "Invalid token."
        case .internalError:
            return "Internal server error."
        }
    }
}

enum Response {
    case json(_: Data?)
    case error(_: Int?, _: Error, _: Data?)

    init(_ response: (data: Data?, resp: HTTPURLResponse?, error: Error?), for request: ServiceRequest) {
        if let error = response.error {
            self = .error(response.resp?.statusCode, error, response.data)
            return
        } else if response.resp?.statusCode == 401 {
            self = .error(response.resp?.statusCode, ResponseError.unauthorized, response.data)
            return
        } else if let httpErrorCode = response.resp?.statusCode,
            httpErrorCode < 200 || httpErrorCode > 299 {
            self = .error(response.resp?.statusCode, ResponseError.internalError, response.data)
            return
        }

        let data = response.data ?? Data()

        switch request.dataType {
        case .json:
            self = .json(data)
        }
    }
}
