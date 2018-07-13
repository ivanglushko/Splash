//
//  AddNoteViewIO.swift
//  Splash
//
//  Created by Ivan Glushko on 05.04.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import Foundation

protocol AddNoteViewOutput: class {
    func createBlog(title: String, fill: String)
    func setBlogPresenter(with: AddNoteModuleOutput?)
}
protocol AddNoteModuleOutput: class {
    func didAddNote()
}
