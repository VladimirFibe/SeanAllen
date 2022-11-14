//
//  AvatarView.swift
//  DubDubGrub
//
//  Created by Vladimir Fibe on 13.11.2022.
//

import SwiftUI

struct AvatarView: View {
    let image: String
    let width: CGFloat
    var body: some View {
        Image(image)
            .resizable()
            .scaledToFill()
            .frame(width: width, height: width)
            .clipShape(Circle())
    }
}

struct FirstNameAvatarView: View {
    let image: String
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
struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(image: "default-square-asset", width: 80)
    }
}
