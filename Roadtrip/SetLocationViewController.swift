//
//  SetLocationViewController.swift
//  Roadtrip
//
//  Created by David Krakauer on 6/20/16.
//  Copyright © 2016 David Krakauer. All rights reserved.
//
import Foundation
import UIKit
import CoreLocation
import MapKit

class SetLocationViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let lm = CLLocationManager()
    let g = CLGeocoder()
    var addressField = ""
    var lat1 : Double = 0.0
    var long1 : Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(addressField)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        g.geocodeAddressString(addressField, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("Error", error)
            }
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                let placeMark = MKPointAnnotation()
                placeMark.coordinate = coordinates
                placeMark.title = "Your location"
                self.mapView.addAnnotation(placeMark)
                
                self.lat1 = coordinates.latitude
                self.long1 = coordinates.longitude
                let initialLocation = CLLocation(latitude: self.lat1, longitude: self.long1)
                self.centerMapOnLocation(initialLocation)
            }
        })
    }
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
