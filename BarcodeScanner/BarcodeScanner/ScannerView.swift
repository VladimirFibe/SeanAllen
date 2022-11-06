import SwiftUI

struct ScannerView: UIViewControllerRepresentable {
    @EnvironmentObject var viewModel: BarcodeScannerViewModel
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    
    func makeUIViewController(context: Context) -> ScannerViewController {
        let controller = ScannerViewController(scannerDelegate: context.coordinator)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: ScannerViewController, context: Context) {
        
    }
    
    final class Coordinator: NSObject, ScannerViewControllerDelegate {
        private let parent: ScannerView
        
        init(parent: ScannerView) {
            self.parent = parent
        }
        func didFind(barcode: String) {
            parent.viewModel.scannedCode = barcode
        }
        
        func didSurface(error: CameraError) {
            parent.viewModel.didSurface(error: error)
        }
    }
}
