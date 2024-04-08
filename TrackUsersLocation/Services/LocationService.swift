//
//  LocationService.swift
//  TrackUsersLocation
//
//  Created by Habip Yesilyurt on 8.04.2024.
//

import MapKit

final class LocationService {
    func calculateRoute(
        from source: CLLocationCoordinate2D,
        to destination: CLLocationCoordinate2D,
        completion: @escaping (Result<MKRoute, Error>) -> Void
    ) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: source))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            if let route = response?.routes.first {
                completion(.success(route))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
}
