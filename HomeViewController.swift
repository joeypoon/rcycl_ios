//
//  HomeViewController.swift
//  rcycl
//
//  Created by Joey Poon on 3/6/16.
//  Copyright © 2016 rcycl. All rights reserved.
//

import UIKit
import CoreLocation

let session = Session()
var locManager = CLLocationManager()

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        locManager.requestWhenInUseAuthorization()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowUserLogin" {
            session.type = "user"
        } else if segue.identifier == "ShowDriverLogin" {
            session.type = "driver"
        }
    }

}