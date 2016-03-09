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

    @IBOutlet weak var requestPickupPressed: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestPickupPressed.layer.cornerRadius = 20
        datePicker.minimumDate = NSDate()
    }
    
    @IBAction func schedulePickupPressed(sender: UIButton) {
        let parameters = [
            "pickup": [
                "user_id": session.id,
                "time": datePicker.date
            ]
        ]
        
        let headers = [
            "x-auth-token": session.auth_token
        ]
        
        var title = ""
        var message = ""
        
        Alamofire.request(.POST, "\(session.rootURL)pickups", parameters: parameters, headers: headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    title = "rcycled!"
                    message = "Pickup scheduled"
                case .Failure:
                    title = "Error"
                    message = "Unable to process request"
                }
                
                let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func logoutPressed(sender: AnyObject) {
        session.logout()
        performSegueWithIdentifier("ShowUserLogout", sender: sender)
    }
}
