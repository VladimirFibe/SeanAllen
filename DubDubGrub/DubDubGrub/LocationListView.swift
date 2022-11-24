import SwiftUI

struct LocationListView: View {
    @EnvironmentObject private var locationManager: LocationManager
    @StateObject private var viewModel = LocationListViewModel()
    var body: some View {
        NavigationView {
            List {
                ForEach(locationManager.locations) { location in
                    let profiles = viewModel.checkedInProfiles[location.id, default: []]
                    let viewModel = LocationDetailViewModel(location: location)
                    NavigationLink(destination: LocationDetailView(viewModel: viewModel)) {
                        LocationCell(location: location, profiles: profiles)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Grub Spots")
            .onAppear { viewModel.getCheckedInProfilesDictionary() }
        }
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView().environmentObject(LocationManager())
    }
}
