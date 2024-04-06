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
        return mapView
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
        // Harita görüntüsünü güncelle
        if let currentLocation = viewModel.locationManager.currentLocation {
            let region = MKCoordinateRegion(
                center: currentLocation.coordinate,
                latitudinalMeters: 1000,
                longitudinalMeters: 1000
            )
            mapView.setRegion(region, animated: true)
        }
        
        // Mevcut marker'ları ekle
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
        
        // Rotayı sıfırladıktan sonra haritayı güncelle
         if viewModel.route == nil {
             mapView.removeOverlays(mapView.overlays)
         }
    }

    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(self)
    }
}
