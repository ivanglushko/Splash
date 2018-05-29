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
        
        self.urls?.forEach{ $0.isCurrent = false }
        self.urls?[index].isCurrent = true
        CoreDataHelper.shared.save()
        self.view?.reloadData()
        
        
    }
    
    // MARK: CoreData Methods
    func createChannel(url: String) {
        self.urls?.forEach { $0.isCurrent = false}
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
