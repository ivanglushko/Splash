//
//  SettingsTableViewController.swift
//  Splash
//
//  Created by Ivan Glushko on 03/04/2018.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import UIKit


class SettingsTableViewController: UITableViewController {
    var output: SettingsViewOutput {
        let presenter = SettingsPresenter()
        presenter.view = self
        return presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

extension SettingsTableViewController {
    func setCells(indexPath: Int) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = urls?[indexPath]
        return cell
    }
}

extension SettingsTableViewController: SettingsViewInput {
    var urls: [String]? {
        get {
            return output.returnUrls()
        }
        set {
            self.urls = newValue
        }
    }
    

}
