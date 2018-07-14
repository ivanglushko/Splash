//
//  TableViewController.swift
//  Splash
//
//  Created by Ivan Glushko on 29.03.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import UIKit
import ChameleonFramework

class FeedTableViewController: UITableViewController {
    
    private lazy var newLinkLabel: NewLinkLabel = NewLinkLabel()
    private let articleCellReuseId = "ArticleCell"
    private lazy var output: FeedViewOutput = {
        let presenter = FeedPresenter()
        presenter.view = self
        return presenter
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .paleGreen
        output.triggerViewReadyEvent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.triggerViewWillAppearEvent()
        self.navigationItem.title = output.setNavigationItemTitle()
    }
}

// MARK: - UITableViewDataSource
extension FeedTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: articleCellReuseId) as? ArticleCell else {
            debugPrint("\(#file): Can't dequeue reusable cell with identifier \(articleCellReuseId)")
            return UITableViewCell()
        }
        
        let article = output.article(for: indexPath)
        cell.configure(with: article)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FeedTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.tapArticle(with: indexPath.row)
    }
}

// MARK: - FeedViewInput
extension FeedTableViewController: FeedViewInput {
    func setupInitialState() {
        tableView.estimatedRowHeight = 155.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.addSubview(newLinkLabel)
        newLinkLabel.center = tableView.center
        newLinkLabel.isHidden = true
    }
    
    func reloadData() {
        self.navigationItem.title = output.setNavigationItemTitle()
        tableView.reloadData()
    }
    
    func showHint() {
        newLinkLabel.text = NewLinkLabel().text
        newLinkLabel.isHidden = false
    }
    
    func configureNewLinkLabel(with state: State) {
        newLinkLabel.isHidden = false
        newLinkLabel.text = state.rawValue
        print(newLinkLabel.text!)
    }
    
    func hideHint() {
        newLinkLabel.isHidden = true
    }
}
