//
//  Extensions.swift
//  TrackUsersLocation
//
//  Created by Habip Yesilyurt on 8.04.2024.
//

import CoreLocation

extension CLPlacemark {
    var compactAddress: String {
        var addressString = ""
        if let name = name {
            addressString += name + ", "
        }
        if let street = thoroughfare {
            addressString += street + ", "
        }
        if let city = locality {
            addressString += city + ", "
        }
        if let state = administrativeArea {
            addressString += state + " "
        }
        if let zip = postalCode {
            addressString += zip
        }
        if addressString.isEmpty {
            addressString = "Address not found"
        }
        return addressString
    }
}
