//
//  Modifiers.swift
//  TrackUsersLocation
//
//  Created by Habip Yesilyurt on 7.04.2024.
//

import SwiftUI

struct BlueButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(Color(red: 0, green: 0, blue: 0.5))
            .foregroundColor(.white)
            .cornerRadius(12)
    }
}
