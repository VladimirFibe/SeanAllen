//
//  CloseButton.swift
//  Appetizers
//
//  Created by Vladimir Fibe on 08.11.2022.
//

import SwiftUI

struct XDismissButton: View {
    let action: () -> ()
    let color = Color.white.opacity(0.6)
    var body: some View {
        Button(action: action) {
            if #available(iOS 15.0, *) {
                image
                    .background(color, in: Circle())
            } else {
                image
                    .background(Circle().fill(color))
            }
        }
    }
    var image: some View {
        Image(systemName: "xmark")
            .frame(width: 44, height: 44)
            .foregroundColor(.black)
    }
}

struct CloseButton_Previews: PreviewProvider {
    static var previews: some View {
        XDismissButton() {}
            .padding()
            .background(Color.gray)
    }
}
