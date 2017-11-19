//
//  Job.swift
//  ghj
//
//  Created by Augusto Falcão on 11/9/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

import Foundation

struct Job: Decodable {
    let id: String
    let title: String
    let location: String
    let type: String
    let company: String
    let company_url: String?
    let company_logo: String?
    let url: String?
}
