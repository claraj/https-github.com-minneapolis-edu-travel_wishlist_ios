//
//  PlaceList.swift
//  TravelWishlistMidterm
//
//  Created by student1 on 1/26/19.
//  Copyright © 2019 clara. All rights reserved.
//
import UIKit
import MapKit

class PlaceList {
    
    var allPlaces = [Place]()

    init() {
        
        let place = Place(name:"Cheese Factory", coordinate: CLLocationCoordinate2D(latitude: 45, longitude: -90))
        let place2 = Place(name:"Yellowstone", coordinate: CLLocationCoordinate2D(latitude: 44, longitude: -110))
        let place3 = Place(name:"Duluth", coordinate: CLLocationCoordinate2D(latitude: 49, longitude: -93), visited: true)

        addPlace(place: place)
        addPlace(place: place2)
        addPlace(place: place3)
        
    }
    
    func addPlace(place: Place) {
        allPlaces.append(place)
    }
    
    func removePlace(_ place: Place) {
        if let index = allPlaces.index(of: place) {
            allPlaces.remove(at: index)
        }

        
    }
    
    
}
