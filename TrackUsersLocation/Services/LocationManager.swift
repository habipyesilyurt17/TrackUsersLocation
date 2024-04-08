//
//  LocationManager.swift
//  TrackUsersLocation
//
//  Created by Habip Yesilyurt on 7.04.2024.
//

import CoreLocation
import SwiftUI

final class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    private var locationManager: CLLocationManager = CLLocationManager()
    
    @Published 
    var currentLocation: CLLocation?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 100
        locationManager.requestAlwaysAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.startUpdatingLocation()
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }

    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        DispatchQueue.main.async {
            self.currentLocation = newLocation
        }
    }
}
