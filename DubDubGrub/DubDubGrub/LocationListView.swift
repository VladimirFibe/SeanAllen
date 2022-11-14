import SwiftUI

struct LocationListView: View {
    var spots: [Spot] = Spot.all
    var body: some View {
        NavigationView {
            List {
                ForEach(spots) { spot in
                    NavigationLink(destination: SpotDetailView(spot: spot)) {
                        SpotRow(spot: spot)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Grub Spots")
        }
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
    }
}


struct SpotRow: View {
    let spot: Spot
    let logoWidth = 80.0
    let avatarWidth = 35.0
    var body: some View {
        HStack {
            AvatarView(image: "default-square-asset", width: 80)
            
            VStack(alignment: .leading) {
                Text(spot.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                Group {
                    if spot.count == 0 {
                        Text("Nobody Checked In")
                            .font(.system(size: 12))
                    } else {
                        HStack {
                            ForEach(0..<5) { index in
                                if index < spot.count {
                                    AvatarView(image: "default-avatar", width: 35)
                                }
                            }
//                            if spot.count > 4 {
//                                Text("+\(spot.count - 4)")
//                                    .font(.system(size: 12))
//                                    .frame(width: avatarWidth, height: avatarWidth)
//                                    .foregroundColor(.white)
//                                    .background(Circle().fill(Color.brandPrimary))
//                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
