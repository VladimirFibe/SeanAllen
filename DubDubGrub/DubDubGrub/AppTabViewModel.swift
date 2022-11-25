import CoreLocation

final class AppTabViewModel: NSObject, ObservableObject {
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

}

extension AppTabViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLoctionAuthorization()
    }
}
