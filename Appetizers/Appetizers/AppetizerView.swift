//
//  AppetizerView.swift
//  Appetizers
//
//  Created by Vladimir Fibe on 06.11.2022.
//

import SwiftUI

struct AppetizerView: View {
    var appetizer: Appetizer
    var body: some View {
        HStack(spacing: 10) {
            AppetizerRemoteImage(urlString: appetizer.imageURL)
                .scaledToFill()
                .frame(width: 120, height: 90)
                .cornerRadius(8)
            VStack(alignment: .leading, spacing: 5.0) {
                Text(appetizer.name)
                    .font(.title2)
                    .fontWeight(.medium)
                Text("$\(appetizer.price, specifier: "%.2f")")
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct AppetizerView_Previews: PreviewProvider {
    static var previews: some View {
        AppetizerView(appetizer: MockData.sampleAppetizer)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
    }
}
