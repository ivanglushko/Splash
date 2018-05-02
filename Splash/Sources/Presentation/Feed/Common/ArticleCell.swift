//
//  ArticleCell.swift
//  Splash
//
//  Created by Букшев Иван Евгеньевич on 10.04.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    
    func configure(with item: ArticleItem) {
        titleLabel.text = item.title
        dateLabel.text = item.pubDateString
        descriptionLabel.text = item.description
        descriptionLabel.numberOfLines = item.expanded ? 0 : 4   // 4 выглядит как магическая константа, кстати
        
    }
}
