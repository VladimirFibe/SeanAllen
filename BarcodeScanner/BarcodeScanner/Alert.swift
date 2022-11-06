import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID().uuidString
    let title: String
    let message: String
    let dismissButton: Alert.Button
}

enum CameraError {
    case invalidDeviceInput
    case invalidScannedValue
}

struct AlertContext {
    static let invalidDeviceInput = AlertItem(title: "Invalid Device Input", message: "Something is wrong with the camera. We are unable to capture the input.", dismissButton: .default(Text("OK")))
    static let invalidScannedType = AlertItem(title: "Invalid Scanned Input", message: "The value scanned is not valid. This app scans EAN-8 and EAN-13.", dismissButton: .default(Text("OK")))
}
