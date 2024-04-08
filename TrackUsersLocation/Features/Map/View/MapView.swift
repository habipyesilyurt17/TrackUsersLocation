//
//  MapView.swift
//  TrackUsersLocation
//
//  Created by Habip Yesilyurt on 7.04.2024.
//

import MapKit
import SwiftUI

struct MapView: View {

    @StateObject 
    var viewModel = MapViewModel()

    var body: some View {
        ZStack(alignment: .bottom) {
            mapViewContainer()
            VStack {
                addressView()
                Spacer()
                actionButtons()
            }
            .padding(.horizontal, 16)
        }
    }
    
    @ViewBuilder
    private func mapViewContainer() -> some View {
        MapViewContainer(
            isTracking: $viewModel.isTracking,
            route: $viewModel.route,
            markers: $viewModel.markers,
            viewModel: viewModel
        )
        .edgesIgnoringSafeArea(.all)
    }
    
    @ViewBuilder
    private func addressView() -> some View {
        if viewModel.isAddressViewVisible {
            AddressView(address: viewModel.markerAddress ?? "")
                .frame(maxWidth: .infinity, maxHeight: 70)
                .background(Color.primaryColor)
                .cornerRadius(12)
                .transition(.move(edge: .top))
        }
    }
    
    @ViewBuilder
    private func actionButtons() -> some View {
        HStack(spacing: 16) {
            Button {
                if viewModel.isTracking {
                    viewModel.stopTracking()
                } else {
                    viewModel.startTracking()
                }
            } label: {
                Text(viewModel.isTracking ? "Stop Track" : "Start Track")
            }
            .buttonStyle(BlueButton())
            
            Button {
                viewModel.resetRoute()
            } label: {
                Text("Reset Route")
            }
            .buttonStyle(BlueButton())
        }
        .padding(.bottom, 24)
    }
}

#Preview {
    MapView()
}
