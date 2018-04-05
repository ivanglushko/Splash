//
//  BlogTableViewController.swift
//  Splash
//
//  Created by Ivan Glushko on 29.03.18.
//  Copyright © 2018 ivanglushko. All rights reserved.
//

import UIKit

class BlogTableViewController: UITableViewController {
    
    @IBAction func addNote(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "addNote", sender: self)
    }
    
    
}
