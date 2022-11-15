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
