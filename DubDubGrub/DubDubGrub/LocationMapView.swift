import SwiftUI
import MapKit

struct LocationMapView: View {
    @EnvironmentObject private var locationManager: LocationManager
    @StateObject var viewModel = LocationMapViewModel()
    var body: some View {
        ZStack(alignment: .top) {
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: locationManager.locations) { location in
                MapAnnotation(coordinate: location.location.coordinate, anchorPoint: CGPoint(x: 0.5, y: 0.75)) {
                    DDGAnnotaion(location: location,
                                 count: viewModel.checkedInProfiles[location.id, default: 0])
                        .onTapGesture {
                            print(location.name)
                            locationManager.selectedLocation = location
                        }
                }
            }
            .gesture(DragGesture())
                    .onLongPressGesture {
                        print(viewModel.region.center)
                    }
            
//            Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true)
//                .gesture(DragGesture())
//                .gesture(                     LongPressGesture()
//                    .onEnded { value in                             print("LongPressGesture "+value.description)                         }                     )
            
            
            .accentColor(.grubRed)
            .ignoresSafeArea(.all, edges: .top)
            LogoView().shadow(radius: 10)
        }
        .sheet(item: $locationManager.selectedLocation, content: { location in
            NavigationView {
                LocationDetailView(viewModel: LocationDetailViewModel(location: location))
            }
        })
        .alert(item: $viewModel.alertItem) { item in
            Alert(title: item.title,
                  message: item.message,
                  dismissButton: item.dismissButton)
        }
        .onAppear {
            if locationManager.locations.isEmpty {
                viewModel.getLocations(for: locationManager)
            }
            viewModel.getCheckedInCounts()
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
