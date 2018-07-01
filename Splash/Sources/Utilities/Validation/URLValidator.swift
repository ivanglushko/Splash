//
//  URLValidator.swift
//  Splash
//
//  Created by Ivan Glushko on 01.04.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import Foundation

protocol URLValidatorProtocol {
    func isValid(text: String) -> Bool
}

struct URLValidator: URLValidatorProtocol {
    func isValid(text: String) -> Bool {
        return text.hasPrefix("https://") && text.hasSuffix("rss")
    }

}
