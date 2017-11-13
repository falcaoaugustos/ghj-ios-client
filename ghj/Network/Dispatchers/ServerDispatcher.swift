//
//  ServerDispatcher.swift
//  ghj
//
//  Created by Augusto Falcão on 11/13/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

import Foundation

protocol ServerDispatcherDelegate {
    func didReceiveRequestResponseData(_ data: Data?)
}

class ServerDispatcher: RequestDispatcher {
    private var environment: String
    var delegate: ServerDispatcherDelegate? = nil

    required init(environment: String) {
        self.environment = environment
    }

    func execute(request: ServiceRequest) {
        let requestUrl = prepareURLRequest(for: request)

        switch request.dataType {
        case .json:
            var req = URLRequest(url: requestUrl)
            req.httpBody = request.body
            req.allHTTPHeaderFields = request.header
            req.httpMethod = request.method.rawValue

            URLSession.shared.dataTask(with: req) { (data, resp, error) in
                let serverResponse = Response((data: data, resp: resp as? HTTPURLResponse, error: error), for: request)

                switch serverResponse {
                case let .error(httpErrorCode, error, _):
                    print("Error: \(httpErrorCode ?? 0) -> \(error.localizedDescription)")
                case .json(let data):
                    self.delegate?.didReceiveRequestResponseData(data)
                }
            }.resume()
        }
    }

    private func prepareURLRequest(for request: ServiceRequest) -> URL {
        return URL(string: "\(environment)\(request.path)")!
    }
}
