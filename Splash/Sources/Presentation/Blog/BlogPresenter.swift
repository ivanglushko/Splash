//
//  BlogPresenter.swift
//  Splash
//
//  Created by Ivan Glushko on 01.06.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import Foundation
import ChameleonFramework

class BlogPresenter {
    weak var view: BlogViewInput?
    private var blogs: [Blog]?
}

extension BlogPresenter: BlogViewOutput {
    func fetchBlogs() {
        self.blogs = CoreDataHelper.shared.fetch(entity: "Blog") as? [Blog]
        view?.reloadData()
    }
    
    func returnNumberOfRows() -> Int {
        return blogs?.count ?? 0
    }
    
    func configureCell(cell: BlogCell, indexPath: IndexPath) -> BlogCell {
        cell.titleLabel.text = blogs?[indexPath.row].title
        cell.fillLabel.text = blogs?[indexPath.row].fill
        cell.titleLabel.numberOfLines = 0
        cell.fillLabel.numberOfLines = cell.expanded ? 0 : 4
        let hexColor = blogs?[indexPath.row].hexColor
        let color = UIColor(hexString: hexColor ?? UIColor.oceanBlue.hexString)

        cell.backgroundColor = color
        cell.titleLabel.textColor = ContrastColorOf(color, returnFlat: true)
        cell.fillLabel.textColor = ContrastColorOf(color, returnFlat: true)
        return cell
    }
}
