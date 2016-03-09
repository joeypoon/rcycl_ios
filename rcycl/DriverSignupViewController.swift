//
//  DriverSignupViewController.swift
//  rcycl
//
//  Created by Joey Poon on 3/8/16.
//  Copyright © 2016 rcycl. All rights reserved.
//

import UIKit
import Alamofire

class DriverSignupViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signupPressed(sender: AnyObject) {
        guard let email = emailField.text,
            let password = passwordField.text,
            let password_confirmation = confirmPasswordField.text,
            let name = nameField.text
            else {
                return
        }
        
        let parameters = [
            "\(session.type)": [
                "name": name,
                "email": email,
                "password": password,
                "password_confirmation": password_confirmation
            ]
        ]
        
        Alamofire.request(.POST, "\(session.rootURL)\(session.type)s", parameters: parameters)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    guard let json = response.result.value,
                        let driver = json["driver"],
                        let auth_token = driver?["auth_token"],
                        let id = driver?["id"]
                        else {
                            return
                    }
                    
                    session.auth_token = auth_token as! String
                    session.id = id as! Int
                    
                    if session.auth_token != "" {
                        self.performSegueWithIdentifier("ShowHomeFromDriverSignup", sender: sender)
                    }
                case .Failure:
                    let message = "Must enter valid address"
                    let alertController = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
                
        }
    }

}
