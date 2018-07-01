//
//  AddNoteViewController.swift
//  Splash
//
//  Created by Ivan Glushko on 29.03.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController {
    @IBOutlet private weak var textTitle: UITextView!
    @IBOutlet private weak var textFill: UITextView!
    private lazy var output: AddNoteViewOutput = {
        let presenter = AddNotePresenter()
        presenter.view = self
        return presenter
    }()
    private let defaultTitle = "Title..."
    private let defaultFill = "Share your thoughts!"
    override func viewDidLoad() {
        super.viewDidLoad()
        createBarButton()
        setPlaceholder(textView: textTitle)
        setPlaceholder(textView: textFill)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    @objc func addNote() {
        let title = textTitle.text ?? ""
        let fill = textFill.text ?? ""
        output.createBlog(title: title, fill: fill)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.popViewController(animated: false)
    }
    func createBarButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(addNote) )
        self.navigationItem.rightBarButtonItem = button
    }
}

// MARK: - UITextDelegate
extension AddNoteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            setPlaceholder(textView: textView)
        }
    }
    private func setPlaceholder(textView: UITextView) {
        textView.delegate = self
        textView.textColor = .lightGray
        if textView == textTitle {
            textView.text = defaultTitle
            self.textTitle = textView
        }
        if textView == textFill {
            textView.text = defaultFill
            self.textFill = textView
        }
    }
}

extension AddNoteViewController: AddNoteViewInput {
}
