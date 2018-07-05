//
//  RFC2822DateFormatter.swift
//  Splash
//
//  Created by Ivan Glushko on 04/07/2018.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import Foundation

class RFC2822DateFormatter: DateFormatter {
    
    override init() {
        super.init()
        locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale!
        dateFormat = "EEE, dd MMM yyyy HH:mm:ss Z"
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
