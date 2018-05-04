//
//  LocationService.swift
//  CarRecognition
//
//  Created by Fei Dong on 2018-05-04.
//  Copyright © 2018 Samira Daneshyar. All rights reserved.
//

import Foundation
import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationService()
    
    let locationManager = CLLocationManager()
    var geocoderFailureCount = 0
    var delegate: LocationServiceDelegate!
    
    var location: CLLocation?
    
    func getUserLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.authorizationStatus() != CLAuthorizationStatus.notDetermined {
            startMonitoringLocation()
        }
    }
    
    func startMonitoringLocation() {
        let status = CLLocationManager.authorizationStatus()
        if status == .denied {
            return
        }
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }

    // MARK:- CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = manager.location {
            locationManager.stopUpdatingLocation()
            self.location = location
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        startMonitoringLocation()
    }
}

protocol LocationServiceDelegate {
    func didFinishGettingUserLocation(location: CLLocation)
}
