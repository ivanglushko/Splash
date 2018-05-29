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
    private lazy var newLinkLabel = NewLinkLabel()
    private lazy var arrowHintImageView = ArrowHintImageView()
    
    // MARK: - Entities
    private let kArticleCellReuseId = "ArticleCell"
    
    let presenter = FeedPresenter()
    private var output: FeedViewOutput!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        output = presenter
        output.triggerViewReadyEvent()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        output.triggerViewWillAppearEvent()
        animateArrow(view: arrowHintImageView)
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
        output.tapArticle(with: indexPath.row)
    }
}

// MARK: - Animations
private extension FeedTableViewController {
    func animateArrow(view: UIView) {
        UIView.animate(withDuration: 1) {
            view.center.y += 50
            view.alpha = 1
            view.center.y += 50
        }
    }
}

// MARK: - FeedViewInput
extension FeedTableViewController: FeedViewInput {
    func setupInitialState() {
        tableView.estimatedRowHeight = 155.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.addSubview(newLinkLabel)
        newLinkLabel.center = tableView.center
        tableView.addSubview(arrowHintImageView)
        arrowHintImageView.center.y -= 100
        arrowHintImageView.alpha = 0
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func showHints() {
        newLinkLabel.isHidden = false
        arrowHintImageView.isHidden = false
    }
    
    func showParsingError() {
        arrowHintImageView.isHidden = true
        newLinkLabel.isHidden = false
        newLinkLabel.text = "Error due parsing."
    }
    func showLoading() {
        arrowHintImageView.isHidden = true
        newLinkLabel.text = "Loading articles..."
    }
    
    func hideHints() {
        newLinkLabel.isHidden = true
        arrowHintImageView.isHidden = true
    }
}
