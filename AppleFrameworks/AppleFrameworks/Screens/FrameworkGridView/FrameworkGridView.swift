import SwiftUI

struct FrameworkGridView: View {
    @EnvironmentObject var viewModel: FrameworkGridViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: viewModel.columns) {
                    ForEach(viewModel.frameworks) { framework in
                        FrameworkTitleView(framework: framework)
                            .onTapGesture {
                                viewModel.selectedFramework = framework
                            }
                    }
                }
            }
            .navigationTitle("🍎 Frameworks")
        }
        .sheet(isPresented: $viewModel.isShowingDetailView) {
            FrameworkDetailView()
                .environmentObject(viewModel)
        }
    }
}

struct FrameworkGridView_Previews: PreviewProvider {
    static var previews: some View {
        FrameworkGridView()
            .environmentObject(FrameworkGridViewModel())
    }
}
