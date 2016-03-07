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
    
    var type = String?()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let type = type else {
            return
        }
        typeLoginLabel.text = "\(type.capitalizedString) Login"
    }

    @IBAction func loginSubmitPressed(sender: UIButton) {
        guard let email = loginEmail.text,
              let password = loginPassword.text,
              let type = type
            else {
                return
        }
        
        let parameters = [
            "\(type)": [
                "email": email,
                "password": password
            ]
        ]

        Alamofire.request(.POST, "\(rootURL)\(type)s/login", parameters: parameters)
            .responseJSON { response in
                guard let json = response.result.value,
                      let user = json["user"] else {
                    return
                }
                
                print(json)
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
