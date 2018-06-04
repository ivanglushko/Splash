//
//  BlogTableViewController.swift
//  Splash
//
//  Created by Ivan Glushko on 29.03.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import UIKit

class BlogTableViewController: UITableViewController {
    
    private let presenter = BlogPresenter()
    var output: BlogViewOutput!
    
    override func viewDidLoad() {
        tableView.backgroundColor = .paleGreen
        self.presenter.view = self
        self.output = presenter
    }
    
    @IBAction func addNote(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addNote", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        output.fetchBlogs()
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
}

extension BlogTableViewController: BlogViewInput {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
