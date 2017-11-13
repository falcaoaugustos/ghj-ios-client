//
//  Dispatcher.swift
//  ghj
//
//  Created by Augusto Falcão on 11/13/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

import Foundation

protocol Dispatcher {
    init(environment: String)
    func execute(request: ServiceRequest) -> Response
}
