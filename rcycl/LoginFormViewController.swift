//
//  LoginFormViewController.swift
//  rcycl
//
//  Created by Joey Poon on 3/6/16.
//  Copyright © 2016 rcycl. All rights reserved.
//

import UIKit
import Alamofire

class LoginFormViewController: UIViewController {

    @IBOutlet weak var typeLoginLabel: UILabel!
    @IBOutlet weak var loginPassword: UITextField!
    @IBOutlet weak var loginEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typeLoginLabel.text = "\(session.type.capitalizedString) Login"
    }

    @IBAction func loginSubmitPressed(sender: UIButton) {
        guard let email = loginEmail.text,
              let password = loginPassword.text
            else {
                return
        }
        
        let parameters = [
            "\(session.type)": [
                "email": email,
                "password": password
            ]
        ]

        Alamofire.request(.POST, "\(session.rootURL)\(session.type)s/login", parameters: parameters)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    guard let json = response.result.value else {
                        return
                    }
                    
                    if session.type == "user" {
                        guard let user = json["user"],
                            let auth_token = user?["auth_token"],
                            let id = user?["id"]
                            else {
                                return
                        }
                        session.auth_token = auth_token as! String
                        session.id = id as! Int
                    } else if session.type == "driver" {
                        guard let driver = json["driver"],
                            let auth_token = driver?["auth_token"],
                            let id = driver?["id"]
                            else {
                                return
                        }
                        session.auth_token = auth_token as! String
                        session.id = id as! Int
                    }
                    
                    if session.auth_token != "" {
                        self.performSegueWithIdentifier("ShowHome", sender: sender)
                    }
                case .Failure:
                    let message = "Invalid email/password combination"
                    let alertController = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
                
            }
        
    }
    
    @IBAction func newUserPressed(sender: UIButton) {
        if session.type == "user" {
            self.performSegueWithIdentifier("ShowUserSignup", sender: sender)
        } else if session.type == "driver" {
            self.performSegueWithIdentifier("ShowDriverSignup", sender: sender)
        }
    }

}