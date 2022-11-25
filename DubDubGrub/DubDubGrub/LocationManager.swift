import Foundation

final class LocationManager: ObservableObject {
    @Published var locations: [DDGLocation] = []
    @Published var selectedLocation: DDGLocation?
}
