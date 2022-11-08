import SwiftUI

struct AppetizerList: View {
    
    @ObservedObject var viewModel = AppetizerViewModel()
    @State private var isShowingDetail = false
    @State private var selectedAppetizer = MockData.sampleAppetizer
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                LoadingView()
            } else {
                if #available(iOS 16.0, *) {
                    NavigationStack { content }
                } else {
                    NavigationView { content }
                }
            }
            if isShowingDetail {
                AppetizerDetaliView(appetizer: selectedAppetizer, isShowingDetail: $isShowingDetail)
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
                        isShowingDetail.toggle() 
                    }
            }
        }
        .listStyle(.plain)
        .navigationTitle("🍿 Appetizer")
    }
}

struct AppetizerList_Previews: PreviewProvider {
    static var previews: some View {
        AppetizerList()
    }
}

