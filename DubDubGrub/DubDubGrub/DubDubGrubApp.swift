import SwiftUI

@main
struct DubDubGrubApp: App {
    let locationManager = LocationManager()
    init() {
        CloudKitManager.shared.getUserRecord()
    }
    var body: some Scene {
        WindowGroup {
            AppTabView().environmentObject(locationManager)
        }
    }
}
