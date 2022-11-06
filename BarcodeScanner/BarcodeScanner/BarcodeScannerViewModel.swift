import SwiftUI

final class BarcodeScannerViewModel: ObservableObject {
    @Published var scannedCode = ""
    @Published var alertItem: AlertItem?
    
    var statusText: String {
        scannedCode.isEmpty ? "Not Yet Scanned" : scannedCode
    }
    
    var statusColor: Color {
        scannedCode.isEmpty ? .red : .green
    }
    func didSurface(error: CameraError) {
        switch error {
        case .invalidDeviceInput:
            alertItem = AlertContext.invalidDeviceInput
        case .invalidScannedValue:
            alertItem = AlertContext.invalidScannedType
        }
    }
}
