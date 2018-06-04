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

    func configure(with item: ArticleItem, numberOfItems: Int, indexPath: IndexPath) {
        titleLabel.text = item.title
        dateLabel.text = item.pubDateString
        descriptionLabel.text = item.description
        descriptionLabel.numberOfLines = item.expanded ? 0 : defaultLinesNumber
        
        if let color = UIColor.paleGreen.darken(byPercentage:(CGFloat(indexPath.row) / CGFloat(numberOfItems)) / 2) {
            backgroundColor = color
            titleLabel.textColor = ContrastColorOf(color, returnFlat: true)
            descriptionLabel.textColor = ContrastColorOf(color, returnFlat: true)
            dateLabel.textColor = ContrastColorOf(color, returnFlat: true)
        }

    }
}
