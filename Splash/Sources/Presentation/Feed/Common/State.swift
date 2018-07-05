//
//  State.swift
//  Splash
//
//  Created by Ivan Glushko on 15/06/2018.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import Foundation

enum State: String {
    case connectionError = "Connection has failed."
    case parsingError = "Error due parsing."
    case loading = "Loading articles..."
}
