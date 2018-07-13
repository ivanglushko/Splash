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
    private var blogPresenter: AddNoteModuleOutput?
}

extension AddNotePresenter: AddNoteViewOutput {
    func createBlog(title: String, fill: String) {
        let defaultTitle = "Title..."
        let defaultFill = "Share your thoughts!"
        let hexColor = RandomFlatColorWithShade(.light).hexString
        let hasTitle = title != defaultTitle && title != ""
        let hasFill = fill != defaultFill && fill != ""
        guard hasTitle else { return }
        let blog = Blog(context: CoreDataHelper.shared.context)
        blog.title = title
        if hasFill { blog.fill = fill }
        blog.hexColor = hexColor
        CoreDataHelper.shared.save()
        blogPresenter?.didAddNote()
    }
    
    func setBlogPresenter(with presenter: AddNoteModuleOutput?) {
        blogPresenter = presenter
    }
}
