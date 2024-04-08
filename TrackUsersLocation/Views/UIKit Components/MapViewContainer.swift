//
//  MapViewContainer.swift
//  TrackUsersLocation
//
//  Created by Habip Yesilyurt on 7.04.2024.
//

import SwiftUI
import MapKit

struct MapViewContainer: UIViewRepresentable {

    @Binding
    var isTracking: Bool
    @Binding
    var route: MKRoute?
    @Binding
    var markers: [Marker]

    @ObservedObject
    var viewModel: MapViewModel

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.delegate = context.coordinator
        
        if !markers.isEmpty {
            viewModel.calculateRouteIfNeeded()
        }

        return mapView
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
        if let currentLocation = viewModel.locationManager.currentLocation {
            let region = MKCoordinateRegion(
                center: currentLocation.coordinate,
                latitudinalMeters: 1000,
                longitudinalMeters: 1000
            )
            mapView.setRegion(region, animated: true)
        }

        if !markers.isEmpty {
            mapView.removeAnnotations(mapView.annotations)
            for marker in markers {
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(
                    latitude: marker.location.latitude,
                    longitude: marker.location.longitude
                )
                annotation.title = marker.title
                annotation.subtitle = marker.subtitle
                mapView.addAnnotation(annotation)
            }
            
            if let route = route {
                mapView.addOverlay(route.polyline)
                mapView.setVisibleMapRect(
                   route.polyline.boundingMapRect,
                   edgePadding: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50),
                   animated: true)
            }
        }
    }

    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(self)
    }
}
