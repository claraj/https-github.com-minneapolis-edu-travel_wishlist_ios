//
//  MapViewController.swift
//  TravelWishlistMidterm
//
//  Created by student1 on 1/26/19.
//  Copyright © 2019 clara. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    var selectedPlacePoint = MKPointAnnotation()
    var selectedPlaceView = MKPinAnnotationView()
    
    var placeList: PlaceList!
    
    var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        mapView = MKMapView()
        view = mapView
        mapView.delegate = self
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(MapViewController.selectPlace(_:)))
        view.addGestureRecognizer(longPressRecognizer)
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        addSubViews()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
         addWishlistPlaces()
    }
    
    
    func updateMap() {
        mapView.removeAnnotations(mapView.annotations)
        addWishlistPlaces()
    }
    
    
    func addWishlistPlaces() {
        
        print("all places: \(placeList.allPlaces)")
        
        for place in placeList.allPlaces {
            let annotation = PlaceAnnotation(place: place)
            mapView.addAnnotation(annotation)
        }
    }
    
    
    @IBAction func selectPlace(_ sender: UILongPressGestureRecognizer) {
        
        let coordOnMap = mapView.convert(sender.location(in: view ), toCoordinateFrom: view)
        //print("\(coordOnMap)")
        
        
        mapView.removeAnnotation(selectedPlacePoint)
        
        // drop a pin on the map here
        selectedPlacePoint.coordinate = coordOnMap
        selectedPlacePoint.title = "Want to go here?"
        
        mapView.addAnnotation(selectedPlacePoint)
    
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let av = MKMarkerAnnotationView()
        av.annotation = annotation

        if let anno = annotation as? PlaceAnnotation {
            av.animatesWhenAdded = true
            av.glyphText = anno.place.mapDisplayName   // in the marker on the map
//            av.title = anno.place.title   // title belongs to annotation, displayed below
            if anno.place.visited {
                av.markerTintColor = Colors.mapVisitedColor
            } else {
                av.markerTintColor = Colors.mapNotVisitedColor
            }
        }
        
        else {
            // user pin drop
            av.markerTintColor = Colors.mapPlaceToAddColor
        }
        //
//        if annotation.place.visited == "Wishlist" {
//            av.pinTintColor = UIColor.yellow
//        } else {
//            av.pinTintColor = UIColor.blue
//        }
//
        return av
        
    }
    
    func addSubViews() {
        let addButton = UIButton()
        addButton.setTitle("Add!", for: .normal)
        addButton.addTarget(self, action: #selector(MapViewController.addPlace(_:)), for: .touchUpInside)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.backgroundColor = UIColor.purple
        
        view.addSubview(addButton)
        
        let margins = view.layoutMarginsGuide
        let topConstraint = addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        let leadingConstraint = addButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = addButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        
  
    }

    @objc func addPlace(_ button: UIButton) {
        print("add place clicked" )
        // Add the annotation to the map as unviisted place
        
            let geoCoder = CLGeocoder()
            let coord = selectedPlacePoint.coordinate
            let location = CLLocation(latitude: coord.latitude, longitude: coord.longitude)
//            location.coordinate = coord
            geoCoder.reverseGeocodeLocation(location, preferredLocale: nil, completionHandler: { (placemarks, error) in self.gotLocation(placemarks: placemarks, error: error) })

        
    }
    
    func gotLocation(placemarks: [CLPlacemark]?, error: Error?) {
        
        print("Geocoder callback \(error) \(placemarks)")
        
        guard let places = placemarks else {
            print("no placenames found")
            return
        }
        
        let firstLocation = places[0]
        
        let name = firstLocation.name
        let locality = firstLocation.locality
        let water = firstLocation.inlandWater
        let country = firstLocation.country
        
        let areasOfInterest = firstLocation.areasOfInterest
        
        print(areasOfInterest, name, locality, water, country )
        
        print("first lo firstLocation \(firstLocation.name)")
        
        var description: String?
        if name != nil && name?.rangeOfCharacter(from: NSCharacterSet.letters) != nil {
            description = name!
        } else if locality != nil {
            description = locality!
        } else if water != nil {
            description = water!
        } else if country != nil {
            if description != nil {
                description = "\(description), \(country)"
            } else {
                description = country
            }
        }
        
        
        let newPlace = Place(name: description ?? "Mystery Place", coordinate: selectedPlacePoint.coordinate)
        placeList.addPlace(place: newPlace)
        updateMap()
    }
    
}
