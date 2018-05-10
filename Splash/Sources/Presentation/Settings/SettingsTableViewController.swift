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

    @IBAction private func addLink(_ sender: UIBarButtonItem) {
        buildAddAlert()
    }
    @IBAction private func deleteAllUrls(_ sender: UIBarButtonItem) {
        buildDeleteAllUrlsAlert()
    }
}

extension SettingsTableViewController {
    func buildAddAlert() {
        let alert = UIAlertController(style: .actionSheet)
        alert.set(message: "Add a link!", font: .systemFont(ofSize: 20), color: .gray)
        var text: String?
        
        let textField: TextField.Config = { textField in
            textField.left(image: #imageLiteral(resourceName: "pen"), color: .black)
            textField.leftViewPadding = 12
            textField.becomeFirstResponder()
            textField.borderWidth = 1
            textField.cornerRadius = 8
            textField.borderColor = UIColor.lightGray.withAlphaComponent(0.5)
            textField.backgroundColor = nil
            textField.placeholder = "Type rss link."
            textField.action { textField in
                text = textField.text
            }
        }
        
        alert.addOneTextField(configuration: textField)
        alert.addAction(title: "OK", color: .gray, style: .default, isEnabled: true) { [weak self] action in
            let validator = URLValidator()
            guard let text = text else { return }
            if validator.isValid(text: text) {
                UserDefaults.standard.setValue([text], forKey: "urls")
                self?.reloadData()
            } else if text == "" {
                alert.dismiss(animated: true)
            } else {
                alert.message = "Invalid link try again."
                self?.show(alert, sender: self)
            }

        }
        show(alert, sender: self)
        
    }
    
    func buildDeleteAllUrlsAlert() {
        let alert = UIAlertController(title: "Attention!", message: nil, preferredStyle: .actionSheet)
        alert.set(message: "Do you want to delete all the links?", font: .systemFont(ofSize: 15), color: .red)
        alert.addAction(title: "OK", style: .default, isEnabled: true) { action in
            UserDefaults.standard.setValue(nil, forKey: "urls")
            self.reloadData()
        }
        alert.addAction(title: "Cancel", style: .default)
        show(alert, sender: self)
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
        return cell
    }
    
}

extension SettingsTableViewController: SettingsViewInput {
    
    func reloadData() {
        OperationQueue.main.addOperation {
            self.tableView.reloadData()
        }
    }

}
