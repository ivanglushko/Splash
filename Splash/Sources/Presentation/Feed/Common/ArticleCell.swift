//
//  ArticleCell.swift
//  Splash
//
//  Created by Букшев Иван Евгеньевич on 10.04.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!

    private let defaultLinesNumber = 4

    func configure(with item: ArticleItem) {
        titleLabel.text = item.title
        dateLabel.text = item.pubDateString
        descriptionLabel.text = item.description
        descriptionLabel.numberOfLines = item.expanded ? 0 : defaultLinesNumber
    }
}
