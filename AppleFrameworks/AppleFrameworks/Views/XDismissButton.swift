import SwiftUI

struct XDismissButton: View {
    let action: () -> ()
    var body: some View {
        Button(action: action)  {
            Image(systemName: "xmark")
                .foregroundColor(Color(.label))
                .imageScale(.large)
                .frame(width: 44, height: 44)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}

struct XDismissButton_Previews: PreviewProvider {
    static var previews: some View {
        XDismissButton() {}
    }
}
