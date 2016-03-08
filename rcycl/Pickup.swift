//
//  Pickup.swift
//  rcycl
//
//  Created by Joey Poon on 3/8/16.
//  Copyright © 2016 rcycl. All rights reserved.
//

import Foundation

class Pickup: NSObject {

    var address: String = ""
    var user_id: Int = 0
    var distance: Float = 0.0
    var status: String = ""
    var time: String = ""
    
    init(pickup: NSDictionary) {
        address = pickup["address"] as! String
        user_id = pickup["user_id"] as! Int
        distance = pickup["distance"] as! Float
        status = pickup["status"] as! String
        time = pickup["time"] as! String
    }
    
}
