import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    let url: URL?
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        SFSafariViewController(url: url ?? URL(string: "https://www.apple.com/")!)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
}
