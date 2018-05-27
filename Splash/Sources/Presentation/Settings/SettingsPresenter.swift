//
//  SettingsPresenter.swift
//  Splash
//
//  Created by Ivan Glushko on 05.04.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import Foundation
import CoreData

class SettingsPresenter {
    weak var view: SettingsViewInput?
    
    private var urls = CoreDataHelper.shared.fetch(entity: "Channel") as? [Channel]
    private var filteredUrls: [Channel]?
    
    init() {
        filteredUrls = urls?.filter { return $0.isCurrent }
        urls?.forEach({ (channel) in
            if channel.isCurrent == false {
                filteredUrls?.append(channel)
            }
        })
        self.urls = filteredUrls
    }
}

extension SettingsPresenter: SettingsViewOutput {
    // MARK: UITableViewDataSource
    func numberOfRows() -> Int {
            return urls?.count ?? 0
    }
    
    func url(for indexPath: IndexPath) -> String? {
        return urls?[indexPath.row].name ?? urls?[indexPath.row].url
    }
    
    // MARK: UITableViewDelegate
    func tapLink(with index: Int) {
        
        // make it current
        CoreDataHelper.shared.persistentContainer.performBackgroundTask { context in
            self.urls?.forEach{ $0.isCurrent = false }
            self.urls?[index].isCurrent = true
            try? context.save()
            self.view?.reloadData()
        }
        
        
        
    }
    
    // MARK: CoreData Methods
    func createChannel(url: String) {
        CoreDataHelper.shared.persistentContainer.performBackgroundTask { (context) in
            self.urls?.forEach { $0.isCurrent = false}
            let channel = Channel(context: CoreDataHelper.shared.context)
            channel.id = UUID().uuidString
            channel.url = url
            channel.isCurrent = true
            try? context.save()
            print("Channel has been created")
        }
        
    }
    
    func deleteAllChannels() {
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: Channel.fetchRequest())
        do {
            try CoreDataHelper.shared.context.execute(deleteRequest)
            view?.reloadData()
        } catch let err {
            print ("Error due deletion of channels: \(err)")
        }
    }
    
    func triggerViewReadyEvent() {
        
    }

  
}
