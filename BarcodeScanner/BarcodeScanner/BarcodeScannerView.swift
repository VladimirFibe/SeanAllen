import SwiftUI

struct BarcodeScannerView: View {
    @EnvironmentObject var viewModel: BarcodeScannerViewModel
    var body: some View {
        NavigationView {
            VStack(spacing: 20.0) {
                ScannerView()
                    .frame(maxWidth: .infinity, maxHeight: 300)
                
                Spacer().frame(height: 60)
                Label("Scanned Barcode:", systemImage: "barcode.viewfinder")
                    .font(.title)
                Text(viewModel.statusText)
                    .font(.largeTitle.bold())
                    .foregroundColor(viewModel.statusColor)
            }
            .navigationTitle("Barcode Scanner")
        }
        .navigationSplitViewStyle(.prominentDetail)
        .alert(item: $viewModel.alertItem) { item in
            Alert(title: Text(item.title), message: Text(item.message), dismissButton: item.dismissButton)
        }
    }
}

struct BarcodeScannerView_Previews: PreviewProvider {
    static var previews: some View {
        BarcodeScannerView()
            .environmentObject(BarcodeScannerViewModel())
    }
}
