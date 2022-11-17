import SwiftUI

struct WelcomeView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(spacing: 32.0) {
            Image("ddg-map-logo")
            WelcomeRow(title: "Restaurant Loations", subtitle: "Find places to dine around  the convention center", image: "building.2.crop.circle")
            WelcomeRow(title: "Check In", subtitle: "Let other iOS Devs know where you are", image: "checkmark.circle")
            WelcomeRow(title: "Find Friends", subtitle: "See where other iOS Devs are and join the party", image: "person.2.circle")
        }
        .frame(maxHeight: .infinity)
        .overlay(XDismissButton{ dismiss() }.padding(), alignment: .topTrailing)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

struct WelcomeRow: View {
    let title: String
    let subtitle: String
    let image: String
    var body: some View {
        HStack {
            Image(systemName: image)
            VStack(alignment: .leading) {
                Text(title)
                Text(subtitle)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 40)
    }
}
