import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.color = .brandPrimary
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {}
}

struct LoadingView: View {
    var body: some View {
        VStack {
            if #available(iOS 15.0, *) {
                ProgressView()
            } else {
                Color(.systemBackground)
                    .ignoresSafeArea()
                    .overlay(ActivityIndicator())
            }
        }
    }
}
