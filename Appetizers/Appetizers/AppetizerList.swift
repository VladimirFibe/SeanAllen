import SwiftUI

struct AppetizerList: View {
    
    @ObservedObject var viewModel = AppetizerViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                LoadingView()
            } else {
                if #available(iOS 16.0, *) {
                    NavigationStack { content }
                } else {
                    NavigationView { content }
                }
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

