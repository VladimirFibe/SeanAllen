import MapKit

final class LocationMapViewModel: NSObject, ObservableObject {
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 37.331516,
            longitude: -121.891054),
        span: MKCoordinateSpan(
            latitudeDelta: 0.01,
            longitudeDelta: 0.01))
    @Published var alertItem: AlertItem?
    
    var deviceLocationManager: CLLocationManager?
    
    func checkIfLocationServiceIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            deviceLocationManager = CLLocationManager()
            deviceLocationManager!.delegate = self
            print("divice")
        } else {
            alertItem = AlertContext.locationDisabled
        }
    }
    
    private func checkLoctionAuthorization() {
        guard let deviceLocationManager = deviceLocationManager else { return }
        print(deviceLocationManager.authorizationStatus)
        switch deviceLocationManager.authorizationStatus {
            
        case .notDetermined:
            deviceLocationManager.requestWhenInUseAuthorization()
        case .restricted:
            alertItem = AlertContext.locationRestricted
        case .denied:
            alertItem = AlertContext.locationDenied
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }
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
}

extension LocationMapViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkLoctionAuthorization()
    }
}
