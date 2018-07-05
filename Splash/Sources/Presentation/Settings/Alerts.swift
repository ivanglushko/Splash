//
//  Alerts.swift
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
            guard let text = text else { return }
            guard let exists = self?.output.checkIfUrlExists(url: text) else { return }
            guard !exists else { return }
            let validator = URLValidator()
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
        present(alert, animated: true)
    }
}
