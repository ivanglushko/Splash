//
//  SettingsTableViewController.swift
//  Splash
//
//  Created by Ivan Glushko on 03/04/2018.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import UIKit

protocol SettingsView: class{
    var urls: [String]? {get set}
    func setCells(indexPath: Int) -> UITableViewCell
}

class SettingsTableViewController: UITableViewController {
    fileprivate let feedPresenter = FeedPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedPresenter.settingsView = self
    }
}

// MARK: - TableView Data Source
extension SettingsTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urls?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return { setCells(indexPath: indexPath.row) }()
    }
    
}


extension SettingsTableViewController: SettingsView {
    var urls: [String]? {
        get {
            return feedPresenter.returnUrls()
        }
        set {
            self.urls = newValue
        }
    }
    
    func setCells(indexPath: Int) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = urls?[indexPath]
        return cell
    }
    
    
    
}
