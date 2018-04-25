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

        // По идее, этот модуль нужен нам на случай, если что-то хотим заранее подгрузить в приложение
        // И когда мы сказали Презентеру triggerViewReadyEvent() — вьюха загружена, то:
        // 1. Мы настраиваем её для показа — setupInitialState()
        // 2. Загружаем данные, а как загрузили, то говорим, что нужно переходить на следующий экран
        // То есть делать performSegue во viewDidAppear — ошибка

        // Вот так можно симулировать работу. Типа данные подгружались 2 секунды
        let seconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.view?.openMainScreen()
        }
    }
}
