//
//  FeedCells.swift
//  Splash
//
//  Created by Букшев Иван Евгеньевич on 10.04.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var Description: UILabel!
    
    func configure(with item: ArticleItem) {
        Title.text = item.title
        Date.text = item.pubDateString
        Description.text = item.description
        Description.numberOfLines = item.expanded ? 4 : 0
    }
}
