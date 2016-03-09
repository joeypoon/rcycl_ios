//
//  Session.swift
//  rcycl
//
//  Created by Joey Poon on 3/7/16.
//  Copyright © 2016 rcycl. All rights reserved.
//

import Foundation

class Session: NSObject {

    let rootURL: String = "https://rcycl.herokuapp.com/v1/"
    var type: String = ""
    var id: Int = 0
    var auth_token: String = ""
    
    func logout() {
        type = ""
        id = 0
        auth_token = ""
    }
    
}
