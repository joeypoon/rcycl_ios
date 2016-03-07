//
//  HomeViewController.swift
//  rcycl
//
//  Created by Joey Poon on 3/6/16.
//  Copyright © 2016 rcycl. All rights reserved.
//

import UIKit

let rootURL: String = "https://rcycl.herokuapp.com/v1/"
var user_id: Int? = nil
var driver_id: Int? = nil
var auth_token: String? = nil

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func userLoginPressed(sender: UIButton) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let loginVC = segue.destinationViewController as? LoginFormViewController
        if segue.identifier == "ShowUserLogin" {
            loginVC?.type = "user"
        } else if segue.identifier == "ShowDriverLogin" {
            loginVC?.type = "driver"
        }
    }

}