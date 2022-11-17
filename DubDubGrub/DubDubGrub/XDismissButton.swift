//
//  XDismissButton.swift
//  DubDubGrub
//
//  Created by Vladimir Fibe on 17.11.2022.
//

import SwiftUI

struct XDismissButton: View {
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: "xmark")
                .imageScale(.small)
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
                .background(
                    Circle()
                        .fill(Color.brandPrimary)
                )
                .frame(width: 44, height: 44)
        }
    }
}

struct XDismissButton_Previews: PreviewProvider {
    static var previews: some View {
        XDismissButton(){}
    }
}
