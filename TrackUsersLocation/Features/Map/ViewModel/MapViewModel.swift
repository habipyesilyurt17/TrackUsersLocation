//
//  MapViewModel.swift
//  TrackUsersLocation
//
//  Created by Habip Yesilyurt on 7.04.2024.
//

import Combine
import CoreLocation
import MapKit
import SwiftUI

final class MapViewModel: ObservableObject {
    
    var locationManager = LocationManager()
    private var cancellables = Set<AnyCancellable>()
    
    @Published 
    var isTracking: Bool = false
    @Published 
    var route: MKRoute?
    @Published 
    var markers: [Marker] = []
    
    init() {
        locationManager.$currentLocation
            .sink { [weak self] location in
                guard let location = location else { return }
                if self?.isTracking ?? false {
                    self?.addMarkerIfNeeded(location: location)
                }
            }
            .store(in: &cancellables)
    }
    
    func startTracking() {
        locationManager.startUpdatingLocation()
        isTracking = true
    }

    func stopTracking() {
        locationManager.stopUpdatingLocation()
        isTracking = false
    }
    
    func resetRoute() {
        route = nil
        markers.removeAll()
        isTracking = false
    }

    private func addMarkerIfNeeded(location: CLLocation) {
        let lastMarkerLocation = markers.last?.location ?? Location(latitude: 0, longitude: 0)
        let lastLocation = CLLocation(
            latitude: lastMarkerLocation.latitude,
            longitude: lastMarkerLocation.longitude
        )
        let distance = location.distance(from: lastLocation)

        if distance >= 100 {
            let newMarker = Marker(
                location: Location(
                    latitude: location.coordinate.latitude,
                    longitude: location.coordinate.longitude
                ),
                title: "Marker",
                subtitle: "Subtitle"
            )
            markers.append(newMarker)
        }
    }
}
