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
        HStack {
            Image(systemName: "mappin.circle.fill")
                .font(.largeTitle)
                .foregroundColor(.white)
            Spacer()
            Text(address)
                .font(.system(size: 14))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .lineLimit(3)
            Spacer()
            Spacer()
        }
        .padding()
    }
}

#Preview {
    AddressView(address: "Test address")
}
