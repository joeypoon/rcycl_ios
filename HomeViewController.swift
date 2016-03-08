//
//  HomeViewController.swift
//  rcycl
//
//  Created by Joey Poon on 3/6/16.
//  Copyright © 2016 rcycl. All rights reserved.
//

import UIKit

let session = Session()

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func userLoginPressed(sender: UIButton) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowUserLogin" {
            session.type = "user"
        } else if segue.identifier == "ShowDriverLogin" {
            session.type = "driver"
        }
    }

}