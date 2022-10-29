import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .white], startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
            content
            
        }
    }
    var content: some View {
        VStack {
            Text("Cupertino, CA")
                .font(.system(size: 32, weight: .medium, design: .default))
                .foregroundColor(.white)

            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
