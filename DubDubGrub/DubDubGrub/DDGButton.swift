import SwiftUI

struct DDGButton: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.body.bold())
            .padding(.vertical,8)
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.brandPrimary))
    }
}

struct DDGButton_Previews: PreviewProvider {
    static var previews: some View {
        DDGButton(title: "Save Profile")
    }
}
