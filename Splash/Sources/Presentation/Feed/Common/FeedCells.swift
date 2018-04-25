//
//  FeedCells.swift
//  Splash
//
//  Created by Букшев Иван Евгеньевич on 10.04.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    // FIXME: Нормально ты именуешь. titleLabel, dateLabel, descriptionLabel нужно :)
    // С большой буквы ни в коем случае не называй переменные, это ломает мозг другим программистам
    // В С# так именуют, но не в Swift — сразу кажется, что это класс
    @IBOutlet private weak var Title: UILabel!
    @IBOutlet private weak var Date: UILabel!
    @IBOutlet private weak var Description: UILabel!
    
    func configure(with item: ArticleItem) {
        Title.text = item.title
        Date.text = item.pubDateString
        Description.text = item.description
        Description.numberOfLines = item.expanded ? 4 : 0   // 4 выглядит как магическая константа, кстати
    }
}
