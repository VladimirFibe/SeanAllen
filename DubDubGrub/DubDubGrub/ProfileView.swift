import SwiftUI
import CloudKit

struct ProfileView: View {
    private enum Fields: Int, CaseIterable {
        case firstname, lastname, companyname, bio
    }

    @ObservedObject var viewModel = ProfileViewModel()

    @FocusState private var focusedField: Fields?
    var body: some View {
        VStack(spacing: 20.0) {
            HStack(spacing: 20.0) {
                AvatarView(image: viewModel.avatar, width: 84)
                    .overlay(
                        editImage, alignment: .bottom)
                    .onTapGesture {
                        viewModel.isShownig.toggle()
                    }
                
                VStack(alignment: .leading, spacing: 4) {
                    TextField("First Name", text: $viewModel.firstname)
                        .profileNameStyle()
                        .focused($focusedField, equals: .firstname)
                    TextField("Last Name", text: $viewModel.lastname)
                        .profileNameStyle()
                        .focused($focusedField, equals: .lastname)
                    TextField("Company Name", text: $viewModel.companyname)
                        .focused($focusedField, equals: .companyname)
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
            TextEditor(text: $viewModel.bio)
                .frame(height: 100)
                .padding(.horizontal)
                .overlay(RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.secondary)
                )
                .focused($focusedField, equals: .bio)
            Spacer()
            saveProfileButton.padding(.horizontal, 50)
        }
        .onAppear { viewModel.getProfile() }
        .navigationTitle("Profile")
        .padding()
        .sheet(isPresented: $viewModel.isShownig) {
            PhotoPicker(avatar: $viewModel.avatar)
        }
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button("Done") { focusedField = nil }
            }
        }
        .alert(item: $viewModel.alertItem) { item in
            Alert(title: item.title,
                  message: item.message,
                  dismissButton: item.dismissButton)
        }
    }
    var charactersRemain: some View {
        Group {
            Text("Bio: ")
            +
            Text("\(viewModel.remain)")
                .bold()
                .foregroundColor(viewModel.remain > 0 ? .brandPrimary : .red)
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
            viewModel.createProfile()
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
