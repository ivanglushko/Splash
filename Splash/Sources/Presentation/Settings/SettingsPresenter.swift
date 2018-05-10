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
    
    private var urls = UserDefaults.standard.value(forKey: "urls") as? [String]
    private let feedParser = FeedParser()
    
}

extension SettingsPresenter: SettingsViewOutput {
    // MARK: UITableViewDataSource
    
    func numberOfRows() -> Int {
            return urls?.count ?? 0
    }
    
    func url(for indexPath: IndexPath) -> String? {
        return urls?[indexPath.row]
    }
    
    // MARK: UITableViewDelegate
    func tapLink(with indexPath: Int) {
        if let first = urls?.remove(at: indexPath) {
            urls?.insert(first, at: 0)
            view?.reloadData()
        }
    }
    
    func triggerViewReadyEvent() {
        
    }

  
}
