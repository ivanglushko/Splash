//
//  InitialViewController.swift
//  Splash
//
//  Created by Ivan Glushko on 30.03.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    private lazy var output: InitialViewOutput = {
        let presenter = InitialPresenter()
        presenter.view = self
        return presenter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        output.triggerViewReadyEvent()
    }
}

// MARK: - InitialViewInput
extension InitialViewController: InitialViewInput {

    func openMainScreen() {
        performSegue(withIdentifier: "GoToTabBar", sender: self)
    }
}
