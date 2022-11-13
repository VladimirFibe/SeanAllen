import SwiftUI

struct LocationListView: View {
    var spots: [Spot] = Spot.all
    var body: some View {
        NavigationView {
            List {
                ForEach(spots) { spot in
                    NavigationLink(destination: Text(spot.name)) {
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
    var body: some View {
        HStack {
            Image("default-square-asset")
                .resizable()
                .scaledToFill()
                .frame(width: 70, height: 70)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(spot.name)
                    .bold()
                Group {
                    if spot.count == 0 {
                        Text("Nobody Checked In")
                            .font(.system(size: 12))
                    } else {
                        let count = min(4, spot.count)
                        HStack {
                            ForEach(0..<count) { _ in
                                Image("default-square-asset")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 30, height: 30)
                                    .clipShape(Circle())
                            }
                            if spot.count > 4 {
                                Text("+\(spot.count - 4)")
                                    .font(.system(size: 12))
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.white)
                                    .background(Circle().fill(Color.brandPrimary))
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
