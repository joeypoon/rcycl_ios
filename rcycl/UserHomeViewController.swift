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
                guard let json = response.result.value,
                      let pickup = json["pickup"],
                      let status = pickup?["status"]
                else {
                    return
                }
                
                var title = ""
                var message = ""
                
                if status as? String == "Scheduled" {
                    title = "rcycled!"
                    message = "Pickup scheduled"
                } else {
                    title = "Error"
                    message = "Unable to process request"
                }
                
                let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
}
