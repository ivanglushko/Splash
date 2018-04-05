//
//  SettingsPresenter.swift
//  Splash
//
//  Created by Ivan Glushko on 05.04.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import Foundation

class SettingsPresenter {
    
    weak var view: SettingsViewInput?
    
    fileprivate let urls = UserDefaults.standard.value(forKey: "urls") as? [String]
    fileprivate let feedParser = FeedParser()
    
}

extension SettingsPresenter: SettingsViewOutput {
    func triggerViewReadyEvent() {
        
    }
    
    
    func returnUrls() -> [String]? {
        return urls
    }
    
}
