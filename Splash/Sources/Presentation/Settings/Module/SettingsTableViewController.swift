//
//  SettingsTableViewController.swift
//  Splash
//
//  Created by Ivan Glushko on 03/04/2018.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import UIKit

/**
 Ты нарушил UX дизайн UINavigationBar
 Пользователь ждет что он статичный и будет скроллиться только контент, но скроллитсмя абсолютно всё!
 */
class SettingsTableViewController: UITableViewController {
    var output: SettingsViewOutput {
        let presenter = SettingsPresenter()
        presenter.view = self
        return presenter
    }
    
    @IBAction func addLink(_ sender: UIBarButtonItem) {
        showNewLinkTextFieldPicker()
    }

    @IBAction func deleteAllUrls(_ sender: UIBarButtonItem) {
//        buildDeleteAllUrlsAlert()
    }
}

//extension SettingsTableViewController {
//    func buildAddAlert() {
//        var urlTextField: UITextField?
//        let alert = UIAlertController(title: nil, message: "Add new link", preferredStyle: .alert)
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
//        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
//            guard let text = urlTextField?.text else { return }

//            !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//            !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//            Кстати, этот код должен был быть в презентере. Это же логика уже.
//            Особенно создание каждый раз нового валидатора мне не очень нравится

//            let validator = URLValidator()
//            if validator.isValid(text: text) {

//                !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//                !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//                То есть ты проверял на валидность строку введенную, и если она нормальная,
//                то удалял все старые и добавлял массив из одного элемента в UserDefaults O_O

//                UserDefaults.standard.setValue([text], forKey: "urls")
//                self.reloadData()
//            } else {
//                alert.message = "Invalid link try again."
//                self.present(alert, animated: true)
//            }
//        }
//        alert.addTextField { textField -> Void in
//            urlTextField = textField
//            textField.placeholder = "Rss url"
//        }
//        alert.addAction(cancelAction)
//        alert.addAction(okAction)
//        present(alert, animated: true)
//    }
//
//    func buildDeleteAllUrlsAlert() {
//        let alert = UIAlertController(title: nil, message: "Do you want to delete all links?", preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
//            UserDefaults.standard.setValue(nil, forKey: "urls")
//            self.reloadData()
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
//        alert.addAction(okAction)
//        alert.addAction(cancelAction)
//        present(alert, animated: true)
//    }
//}

// MARK: - TableView Data Source
extension SettingsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Я в Feed сделал хорошо, бери пример оттуда. Полностью перепиши работу с таблицей тут
        return urls?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Кто тебя этому научил? Это же пиздец)
        return { setCells(indexPath: indexPath.row) }()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.tappedOnLink(index: indexPath.row)
    }
}

extension SettingsTableViewController {

    // Тут тоже странное название метода и вообщ
    func setCells(indexPath: Int) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = urls?[indexPath]
        return cell
    }
    
    func saveURL(url: [String]) {
        // Этим слой View не должен заниматься
        UserDefaults.standard.set(url, forKey: "urls")
    }
}

extension SettingsTableViewController: SettingsViewInput {
    // Такое было в Feed, из-за этой дикости может и не работать.
    var urls: [String]? {
        get {
            return output.returnUrls()
        }
        set {
            self.urls = newValue
            guard let url = newValue else { return }
            saveURL(url: url)
        }
    }
    
    func reloadData() {
        OperationQueue.main.addOperation {
            self.tableView.reloadData()
        }
    }
}

private extension SettingsTableViewController {
    // Я создание алерта скопипастил. В таком виде это выглядит плохо (почему, кстати?)
    // Нужно что-то сделать с этим кодом
    func showNewLinkTextFieldPicker() {
        let alert = UIAlertController(style: .alert, title: "New source")
        let config: TextField.Config = { textField in
            textField.becomeFirstResponder()
            textField.textColor = .black
            textField.placeholder = "Type an URL of news source"
            textField.leftViewPadding = 12
            textField.borderWidth = 1
            textField.cornerRadius = 8
            textField.borderColor = UIColor.lightGray.withAlphaComponent(0.5)
            textField.backgroundColor = nil
            textField.keyboardAppearance = .default
            textField.keyboardType = .default
            textField.isSecureTextEntry = true
            textField.returnKeyType = .done
            textField.action { [unowned self] (textField) in
                self.output.triggerAddNewLinkAction(urlString: textField.text)
            }
        }
        alert.addOneTextField(configuration: config)
        alert.addAction(title: "OK", style: .cancel)
        alert.show()
    }
}
