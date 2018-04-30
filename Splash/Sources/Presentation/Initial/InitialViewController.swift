//
//  InitialViewController.swift
//  Splash
//
//  Created by Ivan Glushko on 30.03.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var startupImage: UIImageView!
    
    // MARK: - Entities
    var output: InitialViewOutput {
        let presenter = InitialPresenter()
        presenter.view = self
        return presenter 
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.triggerViewReadyEvent()
    }
}

// MARK: - InitialViewInput
extension InitialViewController: InitialViewInput {
    func setupInitialState() {
    
    }

    func openMainScreen() {
        // FIXME: Здесь нужно делать TabBar рутовым вью-контроллером, а не просто показывать его
        // Объяснять сейчас не стоит, так как это уровень upper-junior, но связано это с иерархией ViewController'ов
        performSegue(withIdentifier: "GoToTabBar", sender: self)
    }
}
