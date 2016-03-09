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
    @IBOutlet weak var nearbyPickupsFooter: UIView!
    
    var pickups: [Pickup] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableHeaderView = nearbyPickupsHeader
        tableView.tableFooterView = nearbyPickupsFooter
        
        if CLLocationManager.locationServicesEnabled() {
            locManager.delegate = self
            locManager.desiredAccuracy = kCLLocationAccuracyBest
            locManager.startUpdatingLocation()
            getNearbyPickups()
        } else {
            print("Boo")
        }
    }
    
    func getNearbyPickups() {
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways) {
            let latitude = locManager.location?.coordinate.latitude
            let longitude = locManager.location?.coordinate.longitude
        
            let parameters: [String : AnyObject] = [
                "latitude": latitude!,
                "longitude": longitude!,
                "distance": 2500 //for testing
            ]
            
            let headers = [
                "x-auth-token": session.auth_token
            ]
            
            Alamofire.request(.GET, "\(session.rootURL)drivers/nearby_pickups", parameters: parameters, headers: headers)
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .Success:
                        let json = response.result.value as! NSDictionary
                        let pickups = json["pickups"] as? [AnyObject]
                        
                        var temp: [Pickup] = []
                        for pickup in pickups! {
                            temp.append(Pickup(pickup: pickup as! NSDictionary))
                        }
                        
                        self.pickups = temp
                        self.tableView.reloadData()
                    case .Failure:
                        let message = "Error processing request"
                        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
                        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                        self.presentViewController(alertController, animated: true, completion: nil)
                    }
            }
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pickups.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("nearbyPickupCell", forIndexPath: indexPath)
        let pickup = self.pickups[indexPath.row]
        cell.textLabel?.text = "Distance: \(pickup.distance), Address: \(pickup.address)"

        return cell
    }

    @IBAction func logoutPressed(sender: AnyObject) {
        session.logout()
        performSegueWithIdentifier("ShowDriverLogout", sender: sender)
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
