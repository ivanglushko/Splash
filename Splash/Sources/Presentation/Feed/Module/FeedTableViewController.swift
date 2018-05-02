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
    private lazy var newLinkLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next", size: 25)
        label.text = "Add new link!"
        let xPoint = (UIScreen.main.bounds.width / 4)
        let yPoint = (UIScreen.main.bounds.height / 4)
        label.frame = CGRect(x: xPoint, y: yPoint, width: 200.0, height: 50.0)
        return label
    }()
    
    private lazy var arrowHintView: UIView = {
        let view = UIView()
        let imageView = UIImageView()
        imageView.image = UIImage(named: "arrowHint")
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        let tabBarHeight = tabBarController!.tabBar.frame.height
        let xPoint = ( width - ((width / 3) / 2) - 64)
        let yPoint = (height - 128) - tabBarHeight
        view.frame = CGRect(x: xPoint, y: yPoint, width: 128, height: 128)
        imageView.frame = CGRect(x: 0, y: 0, width: 128, height: 128)
        view.addSubview(imageView)
        return view
    }()
    
    
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
        animateArrow(view: arrowHintView)
    }
}

// MARK: - UITableViewDataSource
extension FeedTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return output.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Number of rows \(output.numberOfRows())")
        return output.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: kArticleCellReuseId) as? ArticleCell else {
            debugPrint("\(#file): Can't dequeue reusable cell with identifier \(kArticleCellReuseId)")
            return UITableViewCell()
        }

        let item = output.item(for: indexPath)
        cell.configure(with: item)
        print("Cell configured")
        
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
extension FeedTableViewController {
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
        tableView.addSubview(arrowHintView)
        arrowHintView.center.y -= 100
        arrowHintView.alpha = 0
    }

    func reloadData() {

        OperationQueue.main.addOperation {
            self.tableView.reloadData()
        }
    }
    
    func showHints() {
        OperationQueue.main.addOperation {
            self.newLinkLabel.isHidden = false
            self.arrowHintView.isHidden = false
        }
    }
    
    func hideHints() {
        OperationQueue.main.addOperation {
            self.newLinkLabel.isHidden = true
            self.arrowHintView.isHidden = true
        }
    }
}
