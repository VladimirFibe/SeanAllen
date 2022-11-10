//
//  EmptyState.swift
//  Appetizers
//
//  Created by Vladimir Fibe on 10.11.2022.
//

import SwiftUI

struct EmptyState: View {
    var image = "empty-order"
    var message = "Default Message"
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(height: 150)
            
            Text(message)
                .font(.title3)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding()
        }
    }
}

struct EmptyState_Previews: PreviewProvider {
    static var previews: some View {
        EmptyState()
    }
}
