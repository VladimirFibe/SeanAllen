import MapKit

final class LocationMapViewModel: ObservableObject {
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 37.331516,
            longitude: -121.891054),
        span: MKCoordinateSpan(
            latitudeDelta: 0.01,
            longitudeDelta: 0.01))
    @Published var alertItem: AlertItem?
    func getLocations(for locationManager: LocationManager) {
        guard locationManager.locations.isEmpty else { return }
        CloudKitManager.getLocations { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let locations):
                    locationManager.locations = locations
                case .failure(_):
                    self.alertItem = AlertContext.unalbeToGEtLocations
                }
            }
        }
    }
}
