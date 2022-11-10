import SwiftUI

@main
struct AppetizersApp: App {
    @StateObject var viewModel = AppetizerViewModel()
    @StateObject var order = Order()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .environmentObject(order)
        }
    }
}
