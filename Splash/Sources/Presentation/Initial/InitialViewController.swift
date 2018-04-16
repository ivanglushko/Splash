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
    @IBOutlet weak var startupImage: UIImageView!
    
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

    override func viewDidAppear(_ animated: Bool) {
        performSegue(withIdentifier: "GoToTabBar", sender: self)
    }
}

extension InitialViewController: InitialViewInput {
    func setupInitialState() {
    
    }
}
