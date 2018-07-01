//
//  BlogViewIO.swift
//  Splash
//
//  Created by Ivan Glushko on 05.04.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import Foundation

protocol BlogViewInput: class {
    func reloadData()
}

protocol BlogViewOutput: class {
    func deleteBlog(indexPath: IndexPath)
    func returnNumberOfRows() -> Int
    func configureCell(cell: BlogCell, indexPath: IndexPath) -> BlogCell
}
