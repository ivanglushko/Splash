//
//  InitialPresenter.swift
//  Splash
//
//  Created by Ivan Glushko on 30.03.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import Foundation

class InitialPresenter {
    weak var view: InitialViewInput?
}

extension InitialPresenter: InitialViewOutput {
    func triggerViewReadyEvent() {
        DispatchQueue.main.async {
          self.view?.openMainScreen()
        }
    }
}
