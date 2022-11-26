import MapKit
import CloudKit

final class LocationMapViewModel: ObservableObject {
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 37.331516,
            longitude: -121.891054),
        span: MKCoordinateSpan(
            latitudeDelta: 0.01,
            longitudeDelta: 0.01))
    @Published var checkedInProfiles: [CKRecord.ID: Int] = [:]
    @Published var alertItem: AlertItem?
    
    func getLocations(for locationManager: LocationManager) {
        guard locationManager.locations.isEmpty else { return }
        CloudKitManager.shared.getLocations { result in
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
    
    func getCheckedInCounts() {
        CloudKitManager.shared.getCheckedInProfilesCount { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let chekedIntProfiles):
                    self.checkedInProfiles = chekedIntProfiles
                case .failure(let error):
                    print("DEBUG: ", error.localizedDescription)
                }
            }
        }
    }
}


