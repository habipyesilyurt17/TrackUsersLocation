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
    @Published
    var markerAddress: String? = nil
    @Published
    var isAddressViewVisible = false

    private let geocoder = CLGeocoder()
    
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

    func saveMarkers() {
        let encoder = JSONEncoder()
        if let encodedMarkers = try? encoder.encode(markers) {
            UserDefaults.standard.set(encodedMarkers, forKey: "markers")
        }
    }
    
    func loadMarkers() -> [Marker] {
        if let savedMarkers = UserDefaults.standard.data(forKey: "markers") {
            let decoder = JSONDecoder()
            if let loadedMarkers = try? decoder.decode([Marker].self, from: savedMarkers) {
                return loadedMarkers
            }
        }
        return []
    }

    func resetRoute() {
        markers.removeAll()
        UserDefaults.standard.removeObject(forKey: "markers")
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
            saveMarkers()
        }
    }

    func fetchAddress(for coordinate: CLLocationCoordinate2D) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let _ = error {
                self.markerAddress = nil
                return
            }
            
            if let placemark = placemarks?.first {
                self.markerAddress = placemark.compactAddress
            } else {
                self.markerAddress = nil
            }
        }
    }
}
