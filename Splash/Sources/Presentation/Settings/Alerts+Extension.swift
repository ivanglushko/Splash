//
//  Alerts+Extension.swift
//  Splash
//
//  Created by Ivan Glushko on 24.05.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import UIKit


extension SettingsTableViewController {
    func buildAddAlert() {
        let alert = UIAlertController(style: .actionSheet)
        alert.set(message: "Add a link!", font: .systemFont(ofSize: 20), color: .gray)
        var text: String?
        
        let textField: TextField.Config = { textField in
            textField.left(image: #imageLiteral(resourceName: "pen"), color: .black)
            textField.leftViewPadding = 12
            textField.becomeFirstResponder()
            textField.borderWidth = 1
            textField.cornerRadius = 8
            textField.borderColor = UIColor.lightGray.withAlphaComponent(0.5)
            textField.backgroundColor = nil
            textField.placeholder = "Type rss link."
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .none
            textField.action { textField in
                text = textField.text
            }
        }
        
        alert.addOneTextField(configuration: textField)
        alert.addAction(title: "OK", color: .gray, style: .default, isEnabled: true) { [weak self] action in
            let validator = URLValidator()
            guard let text = text else { return }
            if validator.isValid(text: text) {
                self?.output.createChannel(url: text)
                self?.reloadData()
            } else if text == "" {
                alert.dismiss(animated: true)
            } else {
                alert.message = "Invalid link try again."
                self?.show(alert, sender: self)
            }
            
        }
        show(alert, sender: self)
        
    }
    
    func buildDeleteAllUrlsAlert() {
        let alert = UIAlertController(title: "Attention!", message: nil, preferredStyle: .actionSheet)
        alert.set(message: "Do you want to delete all the links?", font: .systemFont(ofSize: 15), color: .red)
        alert.addAction(title: "OK", style: .default, isEnabled: true) { [weak self] action in
            self?.output.deleteAllChannels()
        }
        alert.addAction(title: "Cancel", style: .default)
        show(alert, sender: self)
    }
}
