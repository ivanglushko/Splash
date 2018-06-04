//
//  AddNotePresenter.swift
//  Splash
//
//  Created by Ivan Glushko on 31.05.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import Foundation
import ChameleonFramework

class AddNotePresenter {
    weak var view: AddNoteViewInput?
}

extension AddNotePresenter: AddNoteViewOutput  {
    func createBlog(title: String, fill: String) {
        let defaultTitle = "Title..."
        let defaultFill = "Share your thoughts!"
        let hexColor = RandomFlatColorWithShade(.light).hexString
        
        if title != defaultTitle && title != "" {
            if fill != defaultFill && fill != "" {
                let blog = Blog(context: CoreDataHelper.shared.context)
                blog.title = title
                blog.fill = fill
                blog.hexColor = hexColor
                CoreDataHelper.shared.save()
            } else {
                let blog = Blog(context: CoreDataHelper.shared.context)
                blog.title = title
                blog.hexColor = hexColor
                CoreDataHelper.shared.save()
            }
        }
    }
    
}
