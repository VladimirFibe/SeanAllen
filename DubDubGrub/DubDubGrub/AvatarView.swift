//
//  AvatarView.swift
//  DubDubGrub
//
//  Created by Vladimir Fibe on 13.11.2022.
//

import SwiftUI

struct AvatarView: View {
    let image: UIImage
    let width: CGFloat
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .frame(width: width, height: width)
            .clipShape(Circle())
    }
}

struct FirstNameAvatarView: View {
    let image: UIImage
    let firstName: String
    let width: CGFloat
    var body: some View {
        VStack {
            AvatarView(image: image, width: width)
            Text(firstName)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.75)
        }
    }
}
