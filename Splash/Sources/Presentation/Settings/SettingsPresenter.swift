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
    
    private var channels: [Channel]? {
        var channelsArray = CoreDataHelper.shared.fetch(entity: "Channel") as? [Channel]
        channelsArray?.forEach { channel in
            if channel.isCurrent {
                channelsArray?.removeAll(channel)
                channelsArray?.insert(channel, at: 0)
            }
        }
        return channelsArray
    }
    
}

extension SettingsPresenter: SettingsViewOutput {
    
    func checkIfUrlExists(url: String) -> Bool {
        guard let channels = channels else { return false }
        var exists = false
        channels.forEach { channel in
            if channel.url == url { exists = true }
        }
        return exists
    }
    
    // MARK: UITableViewDataSource
    func numberOfRows() -> Int {
        return channels?.count ?? 0
    }
    
    func url(for indexPath: IndexPath) -> String? {
        guard let channel = channels?[indexPath.row] else { return nil }
        return channel.name ?? channel.url
    }
    
    // MARK: UITableViewDelegate
    func tapLink(with index: Int) {
        
        // make it current
        print("Index :",index)
        self.channels?.forEach{ $0.isCurrent = false }
        self.channels?[index].isCurrent = true
        CoreDataHelper.shared.save()
        self.view?.reloadData()
        
        
    }
    
    // MARK: CoreData Methods
    func createChannel(url: String) {
        self.channels?.forEach { $0.isCurrent = false }
        let channel = Channel(context: CoreDataHelper.shared.context)
        channel.id = UUID().uuidString
        channel.url = url
        channel.isCurrent = true
        CoreDataHelper.shared.save()
        print("Channel has been created")
        
        
    }
    
    func deleteChannelsArticles() {
        let deleteChannelsRequest = NSBatchDeleteRequest(fetchRequest: Channel.fetchRequest())
        let deleteArticlesRequest = NSBatchDeleteRequest(fetchRequest: Article.fetchRequest())
        do {
            try CoreDataHelper.shared.context.execute(deleteChannelsRequest)
            try CoreDataHelper.shared.context.execute(deleteArticlesRequest)
            CoreDataHelper.shared.context.reset()
            view?.reloadData()
        } catch let err {
            print ("Error due deletion of channels: \(err)")
        }
    }
    
    func triggerViewReadyEvent() {
        
    }
    
    
}
