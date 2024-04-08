//
//  AddressView.swift
//  TrackUsersLocation
//
//  Created by Habip Yesilyurt on 8.04.2024.
//

import SwiftUI

struct AddressView: View {

    var address: String

    var body: some View {
        Text(address)
            .font(.system(size: 14))
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .lineLimit(3)
            .padding()
    }
}

#Preview {
    AddressView(address: "Test address")
}
