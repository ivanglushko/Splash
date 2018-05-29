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
    @IBAction private func addLink(_ sender: UIBarButtonItem) {
        buildAddAlert()
    }
    @IBAction private func deleteAllUrls(_ sender: UIBarButtonItem) {
        buildDeleteAllUrlsAlert()
    }
}


// MARK: - TableViewDataSource
extension SettingsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return { setCells(indexPath: indexPath) }()
    }
    // MARK: - TableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.tapLink(with: indexPath.row)
    }

}

extension SettingsTableViewController {
    func setCells(indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = output.url(for: indexPath)
        
        if indexPath.row == 0 {
            cell.backgroundColor = .green
        }
        return cell
    }
    
}

extension SettingsTableViewController: SettingsViewInput {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}
