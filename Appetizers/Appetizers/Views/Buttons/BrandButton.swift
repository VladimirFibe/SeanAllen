//
//  BrandButton.swift
//  Appetizers
//
//  Created by Vladimir Fibe on 07.11.2022.
//

import SwiftUI

struct BrandButton: View {
    let title: LocalizedStringKey
    let action: () -> ()
    var body: some View {
        Button(action: action) { content }
    }
    var content: some View {
        Text(title)
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(Color.brandPrimary)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal, 50)
    }
}

struct BrandButton_Previews: PreviewProvider {
    static var previews: some View {
        BrandButton(title: "Add to order") {}
    }
}
