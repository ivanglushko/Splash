//
//  BlogTableViewController.swift
//  Splash
//
//  Created by Ivan Glushko on 29.03.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import UIKit

class BlogTableViewController: UITableViewController {
    private lazy var output: BlogViewOutput = {
        let presenter = BlogPresenter()
        presenter.view = self
        return presenter
    }()
    override func viewDidLoad() {
        tableView.backgroundColor = .paleGreen
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddNoteViewController {
            destination.blogPresenter = output as? AddNoteModuleOutput
        }
    }
    
    @IBAction func addNote(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addNote", sender: self)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.reloadData()
    }

}

// MARK: - Data Source
extension BlogTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.returnNumberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlogCell") as! BlogCell
        return output.configureCell(cell: cell, indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? BlogCell else { return }
        cell.expanded = !cell.expanded
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: nil) { [weak self] (action, view, actionPerformed) in
            self?.output.deleteBlog(indexPath: indexPath)
            actionPerformed(true)
        }
        action.image = UIImage(named: "delete")
        let configuration = UISwipeActionsConfiguration(actions: [action])
        return configuration
    }
}

extension BlogTableViewController: BlogViewInput {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
