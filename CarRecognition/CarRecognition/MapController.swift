//
//  MapController.swift
//  CarRecognition
//
//  Created by Samira Daneshyar on 5/4/18.
//  Copyright © 2018 Samira Daneshyar. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var btnStart: UIButton!
    let regionRadius: CLLocationDistance = 10000
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation?
    var annotation: MKPointAnnotation?
    //var dealer: Dealer?
    var dealers : [Dealer]?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        dealers = [Dealer]()
        
        mapView.delegate = self

        locationManager = CLLocationManager()
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        annotation = MKPointAnnotation()
        
        
        ///////
        guard let location = LocationService.shared.location else { return }
        AutoAPI.findDealersNearby(coordinate: location.coordinate, onSuccess: { (dealer) in
            print(dealer)
            self.dealers = dealer
            //self.tableView.reloadData()
            
        }) { (error) in
            print(error)
        }
        centerMapOnLocation(location: location)
        let cor = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        annotation?.coordinate = cor
        annotation?.title = "Your location"
        self.mapView.showAnnotations([annotation!], animated: true)
        
        
        if let dealers = dealers {
            for dealer in dealers {
                
                if let name = dealer.sellerName {
                    annotation!.title = name
                }
                if let lat = dealer.latitude, let long = dealer.longitude {
                    if let latitude = CLLocationDegrees(lat), let longitude = CLLocationDegrees(long) {
                        let coordinate = CLLocationCoordinate2D(latitude:latitude, longitude: longitude)
                        annotation!.coordinate = coordinate
                        self.mapView.showAnnotations([annotation!], animated: true)
                        self.mapView.selectAnnotation(annotation!, animated: true)
                    }
                }

            }
          
        }
        
        
    }

    

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "My Marker"
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        var annotationView: MKMarkerAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        annotationView?.glyphText = ""
        annotationView?.markerTintColor = UIColor.green
        return annotationView
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        let location = locations[0] as CLLocation
        currentLocation = location
        
        
        //self.mapView.setRegion(region, animated: true)
    }
    
    
}
