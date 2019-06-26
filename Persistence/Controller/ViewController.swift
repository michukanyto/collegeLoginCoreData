//
//  ViewController.swift
//  Persistence
//
//  Created by english on 2019-06-20.
//  Copyright © 2019 english. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func studentButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "studentSegue", sender: self)
    }
    
    
    @IBAction func teacherButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "teacherSegue", sender: self)
    }
}
