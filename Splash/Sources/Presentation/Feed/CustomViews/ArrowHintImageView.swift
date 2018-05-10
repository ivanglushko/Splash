//
//  ArrowHintView.swift
//  Splash
//
//  Created by Ivan Glushko on 10.05.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import UIKit

class ArrowHintImageView: UIImageView {
    
    private var value: CGRect {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        let tabBarHeight = TabBarViewController().tabBar.frame.height
        let xPoint = ( width - ((width / 3) / 2) - 64)
        let yPoint = (height - 128) - tabBarHeight
        let frame = CGRect(x: xPoint, y: yPoint, width: 128, height: 128)
        return frame
    }
    
    init() {
        super.init(frame: self.value)
        image = UIImage(named: "arrowHint")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
