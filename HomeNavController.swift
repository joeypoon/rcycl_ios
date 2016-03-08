//
//  HomeNavController.swift
//  rcycl
//
//  Created by Joey Poon on 3/7/16.
//  Copyright © 2016 rcycl. All rights reserved.
//

import UIKit

class HomeNavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if session.type == "user" {
            performSegueWithIdentifier("ShowUserHome", sender: self)
        } else if session.type == "driver" {
            performSegueWithIdentifier("ShowDriverHome", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
