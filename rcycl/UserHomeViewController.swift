//
//  UserHomeViewController.swift
//  rcycl
//
//  Created by Joey Poon on 3/7/16.
//  Copyright © 2016 rcycl. All rights reserved.
//

import UIKit
import Alamofire

class UserHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func schedulePickupPressed(sender: UIButton) {
        let parameters = [
            "pickup": [
                "user_id": session.id,
                "time": NSDate()
            ]
        ]
        
        let headers = [
            "x-auth-token": session.auth_token
        ]
        
        Alamofire.request(.POST, "\(session.rootURL)pickups", parameters: parameters, headers: headers)
            .responseJSON { response in
                guard let json = response.result.value else {
                    return
                }
                print(json["pickup"])
        }
    }
}
