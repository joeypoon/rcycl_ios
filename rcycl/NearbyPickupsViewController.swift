//
//  NearbyPickupsViewController.swift
//  rcycl
//
//  Created by Joey Poon on 3/7/16.
//  Copyright © 2016 rcycl. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class NearbyPickupsViewController: UITableViewController, CLLocationManagerDelegate {

    @IBOutlet weak var nearbyPickupsHeader: UIView!
    
    var pickups: NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableHeaderView = nearbyPickupsHeader
        getNearbyPickups()
    }
    
    func getNearbyPickups() -> Void {
        let locManager = CLLocationManager()
        
        guard let latitude = locManager.location?.coordinate.latitude,
              let longitude = locManager.location?.coordinate.longitude
        else {
            return
        }
        
        let parameters = [
            "latitude": latitude,
            "longitude": longitude,
            "distance": 2500 //temp for testing
        ]
        
        let headers = [
            "x-auth-token": session.auth_token
        ]
        
        Alamofire.request(.GET, "\(session.rootURL)drivers/nearby_pickups", parameters: parameters, headers: headers)
            .responseJSON { response in
                let json = response.result.value as! NSDictionary
                self.pickups = json["pickups"] as? [AnyObject]
                
                var temp: [Pickup] = []
                for pickup in self.pickups! {
                    temp.append(Pickup(pickup: pickup as! NSDictionary))
                }
                
                self.pickups = temp
                self.tableView.reloadData()
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pickups?.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("nearbyPickupCell", forIndexPath: indexPath)
        let pickup = pickups?[indexPath.row] as? Pickup
        cell.textLabel?.text = "Distance: \((pickup?.distance)!)"

        return cell
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

}
