//
//  AddNoteViewController.swift
//  Splash
//
//  Created by Ivan Glushko on 29.03.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    @IBOutlet weak var textTitle: UITextView!
    @IBOutlet weak var textFill: UITextView!
    
    
}

// MARK: - Placeholder

extension AddNoteViewController: UITextViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        setPlaceholder(textView: textTitle)
        setPlaceholder(textView: textFill)
    }
    
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
    func setPlaceholder(textView: UITextView) {
        textView.delegate = self
        textView.textColor = .lightGray
        if textView == textTitle {
            textView.text = "Title..."
            self.textTitle = textView
        }
        
        if textView == textFill {
            textView.text = "Share your thoughts!"
            self.textFill = textView
        }
    }
    
}
