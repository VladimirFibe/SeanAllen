//
//  CircleColorButton.swift
//  DubDubGrub
//
//  Created by Vladimir Fibe on 13.11.2022.
//

import SwiftUI

struct CircleColorButton: View {
    let color: Color
    let image: String
    let size: CGFloat
    var action: () -> () = {}
    var body: some View {
        Button(action: action) {
            CircleColorLabel(color: color, image: image, size: size)
        }
    }
}

struct CircleColorButton_Previews: PreviewProvider {
    static var previews: some View {
        CircleColorButton(color: .brandPrimary, image: "phone.fill", size: 22)
    }
}

struct CircleColorLabel: View {
    let color: Color
    let image: String
    let size: CGFloat
    var body: some View {
        Image(systemName: image)
            .resizable()
            .scaledToFit()
            .foregroundColor(.white)
            .frame(width: size, height: size)
            .padding(19)
        .background(Circle().fill(color))
    }
}
