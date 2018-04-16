//
//  TableViewController.swift
//  Splash
//
//  Created by Ivan Glushko on 29.03.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController {
    // MARK: - Outlets
    private lazy var newLinkButton: UIButton = {
        // Отказываемся от такой кнопки
        // Ее нужно либо поверх показывать, либо делать обычный плюсик как айтем в NavigationBar'e
        let button = UIButton()
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        button.frame = CGRect(x: 16, y: (2*screenHeight / 3), width: (screenWidth - 32), height: 64.0)
        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 30.0)
        button.titleLabel?.text = "Add new link!"
        button.setTitle("Add new link", for: .normal)
        button.backgroundColor = UIColor.green
        button.alpha = 0.65
        button.layer.cornerRadius = 30.0
        button.addTarget(self, action: #selector(transferToSettings), for: .touchUpInside)
        return button
    }()
    
    @objc func transferToSettings() {
        self.tabBarController?.selectedIndex = 2
    }
    
    // MARK: - Entities
    private let kArticleCellReuseId = "ArticleCell"
    
    private var output: FeedViewOutput {
        let presenter = FeedPresenter()
        presenter.view = self
        return presenter
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.triggerViewReadyEvent()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        output.triggerViewWillAppearEvent()
    }
}

// MARK: - UITableViewDataSource
extension FeedTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return output.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kArticleCellReuseId) as? ArticleCell else {
            debugPrint("\(#file): Can't dequeue reusable cell with identifier \(kArticleCellReuseId)")
            return UITableViewCell()
        }
        
        let item = output.item(for: indexPath)
        cell.configure(with: item)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FeedTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.tapArticle(with: indexPath)
    }
}

// MARK: - FeedViewInput
extension FeedTableViewController: FeedViewInput {
    func setupInitialState() {
        tableView.estimatedRowHeight = 155.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(ArticleCell.self, forCellReuseIdentifier: kArticleCellReuseId)
        tableView.addSubview(newLinkButton)
    }

    func reloadData() {
        OperationQueue.main.addOperation {
            self.tableView.reloadData()
        }
    }
    
    func showNewLinkButton() {
        newLinkButton.isHidden = false
    }
    
    func hideNewLinkButton() {
        newLinkButton.isHidden = true
    }
}
