import SwiftUI

struct AppTabView: View {
    @AppStorage("isOnboarding") var isOnboarding = true
    @StateObject var viewModel = AppTabViewModel()
    var body: some View {
        TabView {
            LocationMapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
            LocationListView()
                .tabItem {
                    Label("Locations", systemImage: "building")
                }
            NavigationView {
                ProfileView()
            }
            .tabItem {
                Label("Profile", systemImage: "person")
            }
        }
        .sheet(isPresented: $isOnboarding, onDismiss: {
            viewModel.checkIfLocationServiceIsEnabled()
            isOnboarding = false
        }) {
            WelcomeView()
        }
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView().environmentObject(LocationManager())
    }
}
