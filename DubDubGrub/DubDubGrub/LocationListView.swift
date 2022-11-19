import SwiftUI

struct LocationListView: View {
    @EnvironmentObject private var locationManager: LocationManager
    var body: some View {
        NavigationView {
            List {
                ForEach(locationManager.locations) { location in
                    let viewModel = LocationDetailViewModel(location: location)
                    NavigationLink(destination: LocationDetailView(viewModel: viewModel)) {
                        LocationCell(location: location)
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
        LocationListView().environmentObject(LocationManager())
    }
}
