//
//  PlaceAnnotation.swift
//  TravelWishlistMidterm
//
//  Created by student1 on 1/26/19.
//  Copyright © 2019 clara. All rights reserved.
//

import Foundation
import MapKit

class PlaceAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    let place: Place
    
    init(place: Place) {
        self.place = place
        self.coordinate = place.coordinate
        super.init()
    }
    
}
