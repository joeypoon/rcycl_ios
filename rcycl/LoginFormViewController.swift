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
            .responseJSON { response in
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
                
            }
        if session.auth_token != "" {
            performSegueWithIdentifier("ShowHome", sender: sender)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
