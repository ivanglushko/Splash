//
//  SettingsTableViewController.swift
//  Splash
//
//  Created by Ivan Glushko on 03/04/2018.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import UIKit
import ChameleonFramework

class SettingsTableViewController: UITableViewController {
    private let presenter = SettingsPresenter()
    lazy var output: SettingsViewOutput = {
        let presenter = SettingsPresenter()
        presenter.view = self
        return presenter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .paleGreen
        tableView.rowHeight = 70.0
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    @IBAction private func addLink(_ sender: UIBarButtonItem) {
        buildAddAlert()
    }
    
    private func setCells(indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = output.url(for: indexPath)
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        if indexPath.row == 0 { cell.backgroundColor = FlatGreen() }
        return cell
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

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: nil) { [weak self] (action, view, actionPerformed) in
            self?.output.deleteChannel(indexPath: indexPath)
            actionPerformed(true)
        }
        action.image = UIImage(named: "delete")
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
}

extension SettingsTableViewController: SettingsViewInput {

    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}
