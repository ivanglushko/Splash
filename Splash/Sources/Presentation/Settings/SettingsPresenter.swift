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
    
    func tappedOnLink(index: Int) {
        if let first = view?.urls?.remove(at: index) {
            view?.urls?.insert(first, at: 0)
            view?.reloadData()
        }
    }
    
    func returnUrls() -> [String]? {
        return urls
    }
    
}
