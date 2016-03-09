//
//  SignupViewController.swift
//  rcycl
//
//  Created by Joey Poon on 3/8/16.
//  Copyright © 2016 rcycl. All rights reserved.
//

import UIKit
import Alamofire

class UserSignupViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var streetField: UITextField!
    @IBOutlet weak var unitField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var zipCodeField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!

    @IBAction func SignupPressed(sender: UIButton) {
        guard let email = emailField.text,
              let password = passwordField.text,
              let password_confirmation = confirmPasswordField.text,
              let street = streetField.text,
              let unit = unitField.text,
              let city = cityField.text,
              let state = stateField.text,
              let zip_code = zipCodeField.text
        else {
            return
        }
        
        let parameters = [
            "\(session.type)": [
                "email": email,
                "password": password,
                "password_confirmation": password_confirmation,
                "street": street,
                "unit": unit,
                "city": city,
                "state": state,
                "zip_code": zip_code
            ]
        ]
        
        Alamofire.request(.POST, "\(session.rootURL)\(session.type)s", parameters: parameters)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    guard let json = response.result.value,
                          let user = json["user"],
                          let auth_token = user?["auth_token"],
                          let id = user?["id"]
                    else {
                        return
                    }
                    
                    session.auth_token = auth_token as! String
                    session.id = id as! Int
                    
                    if session.auth_token != "" {
                        self.performSegueWithIdentifier("ShowHomeFromUserSignup", sender: sender)
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
