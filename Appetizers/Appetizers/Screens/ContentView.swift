import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView(selection: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Selection@*/.constant(1)/*@END_MENU_TOKEN@*/) {
            AppetizerList().tabItem {
                Label("Main", systemImage: "house")
            }.tag(1)
            ProfileView().tabItem {
                Label("Profile", systemImage: "person")
            }.tag(2)
            OrderView().tabItem {
                Label("Order", systemImage: "bag")
            }
            .tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
