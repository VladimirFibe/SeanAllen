import SwiftUI

struct AppetizerList: View {
    
    @ObservedObject var viewModel = AppetizerViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.appetizers) { appetizer in
                    AppetizerView(appetizer: appetizer)
                }
            }
            .listStyle(.plain)
            .navigationTitle("🍿 Appetizer")
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title,
                  message: alertItem.message,
                  dismissButton: alertItem.dismissButton)
        }
    }
}

struct AppetizerList_Previews: PreviewProvider {
    static var previews: some View {
        AppetizerList()
    }
}

