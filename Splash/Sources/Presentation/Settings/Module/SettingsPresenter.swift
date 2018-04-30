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
    // fileprivate уже можно на private менять, если работает в одном контексте класса
    // + мне не нравится 
    private let urls = UserDefaults.standard.value(forKey: "urls") as? [String]

    private let feedParser = FeedParser()
    private let urlValidator = URLValidator()
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

    func triggerAddNewLinkAction(urlString: String?) {
        if urlValidator.isValid(text: urlString) {
            // TODO: смотри комментарий во ViewController про то, что ты делал при добавлении нового URL
        }
    }
}
