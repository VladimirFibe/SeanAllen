import SwiftUI

struct LocationListView: View {
    @State private var locations: [DDGLocation] = [DDGLocation(record: MockData.location)]
    var body: some View {
        NavigationView {
            List {
                ForEach(locations, id: \.ckRecordID) { location in
                    NavigationLink(destination: LocationDetailView(location: location)) {
                        LocationCell(location: location)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Grub Spots")
        }
        .onAppear {
            CloudKitManager.getLocations { result in
                switch result {
                    
                case .success(let locations):
                    self.locations = locations
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
    }
}
