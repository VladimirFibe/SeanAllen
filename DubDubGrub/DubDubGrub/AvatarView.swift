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

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        AvatarView(image: "default-square-asset", width: 80)
    }
}
