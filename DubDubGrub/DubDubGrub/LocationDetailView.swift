import SwiftUI

struct LocationDetailView: View {
    let location: DDGLocation
    var body: some View {
        VStack {
            bannerImage
            VStack(alignment: .center, spacing: 16) {
                addressLabel
                descriptionView
                buttons
                Text("Who's Here?").font(.title2.bold())
                friends
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            Spacer()
        }
        .navigationTitle(location.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                Button {
                    
                } label: {
                    Text("Dismiss")
                }

            }
        }
    }
    var bannerImage: some View {
        Image(uiImage: location.createBanner())
            .resizable()
            .scaledToFill()
            .frame(height: 100)
    }
    var addressLabel: some View {
        Label(location.address, systemImage: "mappin.and.ellipse")
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.caption)
            .foregroundColor(.secondary)
    }
    var descriptionView: some View {
        Text(location.description)
            .lineLimit(3)
            .minimumScaleFactor(0.75)
    }
    var buttons: some View {
        HStack(spacing: 20) {
            CircleColorButton(color: .brandPrimary, image: "location.fill", size: 22)
            Link(destination: URL(string: location.websiteURL)!) {
                CircleColorLabel(color: .brandPrimary, image: "network", size: 22)
            }
            CircleColorButton(color: .brandPrimary, image: "phone.fill", size: 22)
            CircleColorButton(color: .red, image: "person.fill.xmark", size: 22)
        }
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(
            Capsule()
                .fill(Color(.secondarySystemBackground))
        )
    }
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    var friends: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(0 ..< 15) { item in
                    VStack {
                        AvatarView(image: PlaceholderImage.avatar, width: 80)
                        Text("Name")
                    }
                }
            }
        }
    }
}

struct LocationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LocationDetailView(location: DDGLocation(record: MockData.location))
        }
    }
}
