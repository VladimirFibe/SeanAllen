import SwiftUI

struct SpotRow: View {
    let location: DDGLocation
    let logoWidth = 80.0
    let avatarWidth = 35.0
    var body: some View {
        HStack {
            AvatarView(image: "default-square-asset", width: 80)
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                HStack {
                    ForEach(0..<5) { index in
                        AvatarView(image: "default-avatar", width: 35)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
