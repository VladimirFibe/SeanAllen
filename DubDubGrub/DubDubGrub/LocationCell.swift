import SwiftUI

struct LocationCell: View {
    let location: DDGLocation
    let logoWidth = 80.0
    let avatarWidth = 35.0
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
                HStack {
                    ForEach(0..<5) { index in
                        AvatarView(image: PlaceholderImage.avatar, width: 35)
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
            LocationCell(location: DDGLocation(record: MockData.location))
        }
    }
}
