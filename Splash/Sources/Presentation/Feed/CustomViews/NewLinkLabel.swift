//
//  NewLinkLabel.swift
//  Splash
//
//  Created by Ivan Glushko on 09.05.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import UIKit

class NewLinkLabel: UILabel {

    private let xPoint = (UIScreen.main.bounds.width / 4)
    private let yPoint = (UIScreen.main.bounds.height / 4)
    init() {
        super.init(frame: CGRect(x: xPoint, y: yPoint, width: 300.0, height: 200.0))
        text = "Add new link!"
        font = UIFont(name: "Avenir Next", size: 25)
        numberOfLines = 0
        textAlignment = .center
    }
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
