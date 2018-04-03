//
//  InitialViewController.swift
//  Splash
//
//  Created by Ivan Glushko on 30.03.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import UIKit

protocol InitialView: class{
  var imagePath: String {get}
  func setImage(imageView: UIImageView)
}

class InitialViewController: UIViewController {
  @IBOutlet weak var startupImage: UIImageView!
  let presenter = InitialPresenter()
  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.view = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    setImage(imageView: startupImage)
  }

}

extension InitialViewController: InitialView {
  var imagePath: String {
    return presenter.imagePath
  }
  
  func setImage(imageView: UIImageView) {
    imageView.image = UIImage(named: imagePath)
  }
  
  
}
  

