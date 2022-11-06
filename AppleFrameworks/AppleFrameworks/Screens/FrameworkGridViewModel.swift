import SwiftUI

final class FrameworkGridViewModel: ObservableObject {
    var selectedFramework: Framework? {
        didSet { isShowingDetailView = true }
    }
    
    @Published var isShowingDetailView = false
    
    let frameworks = MockData.frameworks
    let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 3)
    
    var framework: Framework {
        selectedFramework ?? MockData.sampleFramework
    }
}
