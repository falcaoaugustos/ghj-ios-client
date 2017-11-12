//
//  File.swift
//  ghj
//
//  Created by Augusto Falcão on 11/11/17.
//  Copyright © 2017 Augusto Falcão. All rights reserved.
//

import Foundation

class TextFormater {
    static func transformation(text: String) -> String {
        var transformedText = ""
        text.forEach({ transformedText += $0 == " " ? "+" : String($0) })
        return transformedText
    }
}
