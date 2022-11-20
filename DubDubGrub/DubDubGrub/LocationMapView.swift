import SwiftUI
import MapKit

struct LocationMapView: View {
    @EnvironmentObject private var locationManager: LocationManager
    @StateObject var viewModel = LocationMapViewModel()
    @AppStorage("isOnboarding") var isOnboarding = true
    var body: some View {
        ZStack(alignment: .top) {
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: locationManager.locations) { location in
                MapMarker(coordinate: location.location.coordinate, tint: .brandPrimary)
            }
            .accentColor(.grubRed)
            .ignoresSafeArea(.all, edges: .top)
            LogoView().shadow(radius: 10)
        }
        .alert(item: $viewModel.alertItem) { item in
            Alert(title: item.title,
                  message: item.message,
                  dismissButton: item.dismissButton)
        }
        .onAppear {
            viewModel.getLocations(for: locationManager)
        }
        .sheet(isPresented: $isOnboarding, onDismiss: {
            viewModel.checkIfLocationServiceIsEnabled()
            isOnboarding = false
        }) {
            WelcomeView()
        }
    }
}

struct LocationMapView_Previews: PreviewProvider {
    static var previews: some View {
        LocationMapView().environmentObject(LocationManager())
    }
}

struct LogoView: View {
    var body: some View {
        Image("ddg-map-logo")
            .resizable()
            .scaledToFit()
            .frame(height: 70)
    }
}
