import SwiftUI

@main
struct AppleFrameworksApp: App {
    @StateObject var viewModel = FrameworkGridViewModel()
    var body: some Scene {
        WindowGroup {
            FrameworkGridView()
                .environmentObject(viewModel)
        }
    }
}
