//
//  MapViewCoordinator.swift
//  TrackUsersLocation
//
//  Created by Habip Yesilyurt on 7.04.2024.
//

import MapKit
import SwiftUI

final class MapViewCoordinator: NSObject, MKMapViewDelegate {
    var parent: MapViewContainer

    init(_ parent: MapViewContainer) {
        self.parent = parent
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Marker"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }

        if parent.viewModel.isAddressViewVisible {
            annotationView?.markerTintColor = UIColor.primaryColor
        }

        return annotationView
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        parent.viewModel.fetchAddress(for: annotation.coordinate)
        parent.viewModel.isAddressViewVisible.toggle()
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay)
        render.strokeColor = UIColor.primaryColor
        render.lineWidth = 6
        return render
    }
}
