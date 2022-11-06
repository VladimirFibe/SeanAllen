import SwiftUI

@main
struct BarcodeScannerApp: App {
    @StateObject var viewModel = BarcodeScannerViewModel()
    var body: some Scene {
        WindowGroup {
            BarcodeScannerView()
                .environmentObject(viewModel)
        }
    }
}
