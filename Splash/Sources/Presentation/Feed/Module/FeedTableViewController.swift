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
    // MARK: - Outlets
    private lazy var newLinkLabel = NewLinkLabel()
    
    // MARK: - Entities
    private let kArticleCellReuseId = "ArticleCell"
    
    private let presenter = FeedPresenter()
    private var output: FeedViewOutput!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .paleGreen
        presenter.view = self
        output = presenter
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
        let numberOfItems = output.numberOfItems
        let article = output.article(for: indexPath)
        cell.configure(with: article, numberOfItems: numberOfItems, indexPath: indexPath)
        
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
    }
    
    func reloadData() {
        self.navigationItem.title = output.setNavigationItemTitle()
        tableView.reloadData()
    }
    
    func showHint() {
        newLinkLabel.text = NewLinkLabel().text
        newLinkLabel.isHidden = false
    }
    
    func configureNewLinkLabel(with state: NewLinkLabelState) {
        newLinkLabel.isHidden = false
        newLinkLabel.text = state.rawValue
    }
    
    func hideHint() {
        newLinkLabel.isHidden = true
    }
}
