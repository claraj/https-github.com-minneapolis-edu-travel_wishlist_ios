//
//  Place.swift
//  TravelWishlistMidterm
//
//  Created by student1 on 1/26/19.
//  Copyright © 2019 clara. All rights reserved.
//

import MapKit

class Place: NSObject {
    
    let name: String
    var mapDisplayName: String {
        get {
            if name.count < 13 {
                return name
            } else {
                let index = name.index(name.startIndex, offsetBy: 12)
                let truncated = name.substring(to: index) + "..."
                return truncated
            }
        }
    }
    let coordinate: CLLocationCoordinate2D
    var visited: Bool = false
    
    public override var description: String {
        return "Place \(name), \(coordinate.latitude), \(coordinate.longitude), visited? \(visited)"
    }
    
    init(name: String, coordinate: CLLocationCoordinate2D, visited: Bool = false) {
        self.name = name
        self.coordinate = coordinate
        self.visited = visited
    }
    
}
