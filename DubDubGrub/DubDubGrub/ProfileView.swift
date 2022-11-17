import SwiftUI

struct ProfileView: View {
    var remain: Int {
        100 - bio.count
    }
    @State private var firstname    = ""
    @State private var lastname     = ""
    @State private var companyname  = ""
    @State private var bio          = ""
    @State private var avatar       = PlaceholderImage.avatar
    var body: some View {
        VStack(spacing: 20.0) {
            HStack(spacing: 20.0) {
                AvatarView(image: avatar, width: 84)
                    .overlay(
                        editImage, alignment: .bottom)
                
                VStack(alignment: .leading, spacing: 4) {
                    TextField("First Name", text: $firstname)
                        .profileNameStyle()
                    TextField("Last Name", text: $lastname)
                        .profileNameStyle()
                    
                    TextField("Company Name", text: $companyname)
                }
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 130)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.secondarySystemBackground)))
            
            HStack {
                charactersRemain
                checkOutButton
            }
            TextEditor(text: $bio)
                .frame(height: 100)
                .padding(.horizontal)
                .overlay(RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.secondary)
                )
            Spacer()
            saveProfileButton.padding(.horizontal, 50)
            
        }
        .navigationTitle("Profile")
        .padding()
    }
    var charactersRemain: some View {
        Group {
            Text("Bio: ")
            +
            Text("\(remain)")
                .bold()
                .foregroundColor(remain > 0 ? .brandPrimary : .red)
            +
            Text(" characters remain")
        }
        .font(.callout)
    }
    var editImage: some View {
        Image(systemName: "square.and.pencil")
            .resizable()
            .scaledToFit()
            .frame(width: 14, height: 14)
            .foregroundColor(.white)
            .padding(.bottom, 4)
    }
    var checkOutButton: some View {
        Button {
            
        } label: {
            Label("Check Out", systemImage: "mappin.and.ellipse")
                .font(.body.bold())
                .padding(.horizontal)
                .padding(.vertical,8)
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.red))
        }
    }
    var saveProfileButton: some View {
        Button {
            
        } label: {
            DDGButton(title: "Save Profile")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
        }
    }
}
