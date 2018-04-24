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
    
    
    @IBAction func addLink(_ sender: UIBarButtonItem) {
        buildAddAlert()
    }
    @IBAction func deleteAllUrls(_ sender: UIBarButtonItem) {
        buildDeleteAllUrlsAlert()
    }
}

// MARK: - Alerts
extension SettingsTableViewController {
    func buildAddAlert() {
        var urlTextField: UITextField?
        let alert = UIAlertController(title: nil, message: "Add new link", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            guard let text = urlTextField?.text else { return }
            let validator = URLValidator()
            if validator.isValid(text: text) {
                UserDefaults.standard.setValue([text], forKey: "urls")
                self.reloadData()
            } else {
                alert.message = "Invalid link try again."
                self.present(alert, animated: true)
            }
        }
        alert.addTextField { textField -> Void in
            urlTextField = textField
            textField.placeholder = "Rss url"
        }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func buildDeleteAllUrlsAlert() {
        let alert = UIAlertController(title: nil, message: "Do you want to delete all links?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            UserDefaults.standard.setValue(nil, forKey: "urls")
            self.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.tappedOnLink(index: indexPath.row)
    }
}

extension SettingsTableViewController {
    func setCells(indexPath: Int) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = urls?[indexPath]
        return cell
    }
    
    func saveURL(url: [String]) {
        UserDefaults.standard.set(url, forKey: "urls")
    }
}

extension SettingsTableViewController: SettingsViewInput {
    var urls: [String]? {
        get {
            return output.returnUrls()
        }
        set {
            self.urls = newValue
            guard let url = newValue else { return }
            saveURL(url: url)
        }
    }
    
    func reloadData() {
        OperationQueue.main.addOperation {
            self.tableView.reloadData()
        }
    }

}
