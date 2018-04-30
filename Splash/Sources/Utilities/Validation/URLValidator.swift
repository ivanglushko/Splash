//
//  URLValidator.swift
//  Splash
//
//  Created by Ivan Glushko on 01.04.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import Foundation

protocol URLValidatorProtocol {
    func isValid(text: String?) -> Bool
}

struct URLValidator: URLValidatorProtocol  {
    func isValid(text: String?) -> Bool {
        guard let text = text else {
            return false
        }

        let isValidHttp = (text.hasPrefix("http") && text.hasSuffix("rss"))
        let isValidHttps = (text.hasPrefix("https:/") && text.hasSuffix("rss"))

        return isValidHttp || isValidHttps
    }
}
