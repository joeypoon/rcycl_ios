//
//  LoginFormViewController.swift
//  rcycl
//
//  Created by Joey Poon on 3/6/16.
//  Copyright © 2016 rcycl. All rights reserved.
//

import UIKit

class LoginFormViewController: UIViewController {

    @IBOutlet weak var loginPassword: UITextField!
    @IBOutlet weak var loginEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginSubmitPressed(sender: UIButton) {
        guard let email = loginEmail.text,
              let password = loginPassword.text
            else {
                return
        }
        print("\(email) \(password)")
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
