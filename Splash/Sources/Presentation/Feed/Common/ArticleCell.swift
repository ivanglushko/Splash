//
//  ArticleCell.swift
//  Splash
//
//  Created by Букшев Иван Евгеньевич on 10.04.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import UIKit
import ChameleonFramework
class ArticleCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    private let defaultLinesNumber = 4

    func configure(with article: Article?, numberOfItems: Int, indexPath: IndexPath) {
        guard let article = article else { return }
        titleLabel.text = article.title
        dateLabel.text = article.pubDate.dateString() + " at " + article.pubDate.timeString()
        descriptionLabel.text = article.descriptionString
        descriptionLabel.numberOfLines = article.expanded ? 0 : defaultLinesNumber
        
        if let color = UIColor.paleGreen.darken(byPercentage:(CGFloat(indexPath.row) / CGFloat(numberOfItems)) / 2) {
            backgroundColor = color
            titleLabel.textColor = ContrastColorOf(color, returnFlat: true)
            descriptionLabel.textColor = ContrastColorOf(color, returnFlat: true)
            dateLabel.textColor = ContrastColorOf(color, returnFlat: true)
        }

    }
}
