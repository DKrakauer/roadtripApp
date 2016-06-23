//
//  File.swift
//  
//
//  Created by David Krakauer on 6/14/16.
//
//

import Foundation
import MapKit

class tripMarker: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let descriptionLocat: String
    let adminCleared: Bool
    let coordinate: CLLocationCoordinate2D
    let numLikes: Int
    
    init(name: String, subtitle: String, descriptiont: String, adminCleared: Bool, coordinate: CLLocationCoordinate2D, numLikes: Int) {
        self.title = name
        self.subtitle = subtitle
        self.descriptionLocat = descriptiont
        self.adminCleared = adminCleared
        self.coordinate = coordinate
        self.numLikes = numLikes
        
        super.init()
    }

}
