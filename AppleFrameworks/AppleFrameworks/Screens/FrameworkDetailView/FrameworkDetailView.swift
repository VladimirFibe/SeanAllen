import SwiftUI

struct FrameworkDetailView: View {
    
    @EnvironmentObject var viewModel: FrameworkGridViewModel
    @State private var isShowingSafariView = false
    
    var body: some View {
        VStack {
            XDismissButton() {
                viewModel.isShowingDetailView = false
            }

            Spacer()
            FrameworkTitleView(framework: viewModel.framework)
            Text(viewModel.framework.description)
                .font(.body)
            Spacer()
            Button {
                isShowingSafariView = true
            } label: {
                AFButton(title: "Learn More")
            }

        }
        .padding(.horizontal)
        .fullScreenCover(isPresented: $isShowingSafariView) {
            SafariView(url: URL(string: viewModel.framework.urlString))
        }
    }
}

struct FrameworkDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FrameworkDetailView()
            .environmentObject(FrameworkGridViewModel())
    }
}
