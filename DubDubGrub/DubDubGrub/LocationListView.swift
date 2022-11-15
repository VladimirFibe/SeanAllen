import SwiftUI

struct LocationListView: View {
    @State private var locations: [DDGLocation] = [DDGLocation(record: MockData.location)]
    var body: some View {
        NavigationView {
            List {
                ForEach(locations, id: \.ckRecordID) { location in
                    NavigationLink(destination: SpotDetailView(location: location)) {
                        SpotRow(location: location)
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
