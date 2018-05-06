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
        view?.setupInitialState()

        // Вот так можно симулировать работу. Типа данные подгружаются 2 секунды
        let seconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.view?.openMainScreen()
        }
    }
}
