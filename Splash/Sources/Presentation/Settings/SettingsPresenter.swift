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

    private let fetchedResultsController: NSFetchedResultsController<Channel> = {
        let context = CoreDataHelper.shared.context
        let fetchRequest = Channel.fetchRequest() as NSFetchRequest
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "isCurrent", ascending: false)]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultsController
    }()

    private lazy var channels: [Channel]? = {
        return fetchChannels()
    }()
    
    private func fetchChannels() -> [Channel]? {
        do {
            try fetchedResultsController.performFetch()
            let channels = fetchedResultsController.fetchedObjects
            return channels
        } catch let err {
            print("Fetched Results Controller error in fetching: ", err)
            return nil
        }
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
        let channel = self.channels?[index]
        self.channels?.forEach { $0.isCurrent = false }
        channel?.isCurrent = true
        CoreDataHelper.shared.save()
        channels = fetchChannels() 
        self.view?.reloadData()
    }

    // MARK: CoreData Methods
    func createChannel(url: String) {
        channels?.forEach { $0.isCurrent = false }
        let channel = Channel(context: CoreDataHelper.shared.context)
        channel.id = UUID().uuidString
        channel.url = url
        channel.isCurrent = true
        CoreDataHelper.shared.save()
        channels = fetchChannels()
        print("Channel has been created")

    }

    func deleteChannel(indexPath: IndexPath) {
        if let channel = channels?[indexPath.row] {
            CoreDataHelper.shared.delete(object: channel)
            if channel.isCurrent {
                guard let count = channels?.count, count >= 2 else { return }
                let newChannel = channels?[indexPath.row + 1]
                newChannel?.isCurrent = true
            }
            CoreDataHelper.shared.save()
            channels = fetchChannels()
            view?.reloadData()
        }
    }

 }
