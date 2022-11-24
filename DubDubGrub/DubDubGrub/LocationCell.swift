import SwiftUI

struct LocationCell: View {
    let location: DDGLocation
    let logoWidth = 80.0
    let avatarWidth = 35.0
    let profiles: [DDGProfile]
    var body: some View {
        HStack {
            Image(uiImage: location.createSquare())
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                if profiles.isEmpty {
                    Text("Nobody's Checked In").bold()
                        .foregroundColor(.secondary)
                } else {
                    HStack {
                        ForEach(profiles.indices, id: \.self) { index in
                            let profile = profiles[index]
                            if index < 4 {
                                AvatarView(image: profile.createImage(), width: 35)
                            } else if index == 4 {
                                AditionalProfilesView(number: profiles.count - 4)
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct LocationCell_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LocationCell(location: DDGLocation(record: MockData.location), profiles: [])
                .padding()
        }
    }
}

struct AditionalProfilesView: View {
    var number: Int
    var body: some View {
        Text("+\(number)")
            .font(.system(size: 14, weight: .semibold))
            .frame(width: 35, height: 35)
            .foregroundColor(.white)
            .background(Color.brandPrimary)
            .clipShape(Circle())
    }
}
