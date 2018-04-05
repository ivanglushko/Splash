//
//  TableViewController.swift
//  Splash
//
//  Created by Ivan Glushko on 29.03.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import UIKit


class FeedTableViewController: UITableViewController {
    // MARK: - Entities
    var output: FeedViewOutput {
        let presenter = FeedPresenter()
        presenter.view = self
        return presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.triggerViewReadyEvent()
        
    }
}

// MARK: TableView Data Source

extension FeedTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfCells
    }
    
}

// MARK: - Feed View

extension FeedTableViewController: FeedViewInput {
    func setRowHeight() {
        self.tableView.estimatedRowHeight = 155.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    var numberOfCells: Int {
        get {
            return output.numberOfCells()
        }
        set {
            self.numberOfCells = newValue
        }
    }
    
    func updateView() {
        OperationQueue.main.addOperation { () -> Void in
            self.tableView.reloadData()
        }
    }
    
    func buildButton() {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 30.0)
        button.titleLabel?.text = "Add new link!"
        button.setTitle("Add new link", for: .normal)
        button.backgroundColor = UIColor.green
        button.alpha = 0.25
        button.layer.cornerRadius = 35.0
        self.tableView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.tableView.centerYAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 80.0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
        
        
    }
}
