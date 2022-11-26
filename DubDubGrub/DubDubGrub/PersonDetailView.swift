import SwiftUI

struct PersonDetailView: View {
    let width = 100.0
    @Binding var profile: DDGProfile?
    var body: some View {
        if let profile = profile {
            VStack {
                XDismissButton {
                    withAnimation { self.profile = nil }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding([.top, .trailing])
                Text(profile.fistName + " " + profile.lastName)
                    .bold()
                    .font(.title2)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                
                Text(profile.companyName)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                    .foregroundColor(.secondary)
                
                Text(profile.bio)
                    .lineLimit(3)
                Spacer()
            }
            .padding(.horizontal)
            .frame(width: 300, height: 230)
            .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 16))
            .overlay(
                
                AvatarView(image: profile.avatar.convertToUIImage(in: .square), width: width)
                    .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 6)
                    .offset(y: -width/2)
                , alignment: .top
            )
        }
    }
}

struct PersonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailView(profile: .constant(DDGProfile(record: MockData.profile)))
    }
}
