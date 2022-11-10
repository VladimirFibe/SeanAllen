import SwiftUI

struct AppetizerList: View {
    
    @EnvironmentObject var viewModel: AppetizerViewModel
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                LoadingView()
            } else {
                if #available(iOS 16.0, *) {
                    NavigationStack { content }
                        .blur(radius: viewModel.isShowingDetail ? 20 : 0)
                } else {
                    NavigationView { content }
                        .blur(radius: viewModel.isShowingDetail ? 20 : 0)
                }
            }
                
            if viewModel.isShowingDetail {
                AppetizerDetaliView(appetizer: viewModel.selectedAppetizer,
                                    isShowingDetail: $viewModel.isShowingDetail)
            }
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
    }
    var content: some View {
        List {
            ForEach(viewModel.appetizers) { appetizer in
                AppetizerView(appetizer: appetizer)
                    .onTapGesture {
                        viewModel.isShowingDetail.toggle()
                        viewModel.selectedAppetizer = appetizer
                    }
            }
        }
        .listStyle(.plain)
        .disabled(viewModel.isShowingDetail)
        .navigationTitle("🍿 Appetizer")
    }
}

struct AppetizerList_Previews: PreviewProvider {
    static var previews: some View {
        AppetizerList()
            .environmentObject(AppetizerViewModel())
    }
}

