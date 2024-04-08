//
//  Extensions.swift
//  TrackUsersLocation
//
//  Created by Habip Yesilyurt on 8.04.2024.
//

import CoreLocation
import SwiftUI

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

extension Color {
    static var primaryColor: Color {
        return Color(UIColor(red: 0, green: 0, blue: 0.5, alpha: 1.0))
    }
}

extension UIColor {
    static var primaryColor: UIColor {
        return UIColor(red: 0, green: 0, blue: 0.5, alpha: 1.0)
    }
}
