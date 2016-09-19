//
//  MapsViewController.swift
//  Roadtrip
//
//  Created by David Krakauer on 6/6/16.
//  Copyright © 2016 David Krakauer. All rights reserved.
//

import UIKit
import MapKit
import Parse
import ParseUI

class MapsViewController: UIViewController {
    
    var objectIDlocat=""
    var objectHolder:PFObject?
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        let query = PFQuery(className: "Location")
        if objectIDlocat != "" {
            query.getObjectInBackgroundWithId(objectIDlocat) {
            (locat: PFObject?, error: NSError?) -> Void in
            if error == nil && locat != nil {
                if let objectPoints = locat!.objectForKey("Address") as? PFGeoPoint {
                    let latitude1 = objectPoints.latitude * 2
                    let longitude1 = objectPoints.longitude * 2
                    let initialLocation = CLLocation(latitude: latitude1, longitude: longitude1)
                    let placeMarker = tripMarker(name: locat?.objectForKey("Name") as! String, subtitle: locat?.objectForKey("authorName") as! String, descriptiont: locat?.objectForKey("Description") as! String, adminCleared: locat?.objectForKey("adminApproved") as! Bool, coordinate: initialLocation.coordinate, numLikes: locat?.objectForKey("Likes") as! Int)
                    self.mapView.addAnnotation(placeMarker)
                    self.centerMapOnLocation(initialLocation)
                }
            } else {
                print(error)
            }}
        }else{
            print("Error: No Location Object Found")
        }
    }
    let regionRadius: CLLocationDistance = 1000
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
