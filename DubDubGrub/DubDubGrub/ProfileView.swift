import SwiftUI
import CloudKit

struct ProfileView: View {
    private enum Fields: Int, CaseIterable {
        case firstname, lastname, companyname, bio
    }

    @ObservedObject var viewModel = ProfileViewModel()

    @FocusState private var focusedField: Fields?
    
    var body: some View {
        ZStack {
            content
            if viewModel.isLoading { LoadingView() }
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
    var content: some View {
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
                Spacer()
                if viewModel.isCheckedIn {
                    checkOutButton
                }
            }
            TextEditor(text: $viewModel.bio)
                .frame(height: 100)
                .padding(.horizontal)
                .colorMultiply(Color(.secondarySystemBackground))
                .background(Color(.secondarySystemBackground))
                .cornerRadius(8)
                .focused($focusedField, equals: .bio)
            Spacer()
            saveProfileButton.padding(.horizontal, 50)
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
            viewModel.checkOut()
        } label: {
            Label("Check Out", systemImage: "mappin.and.ellipse")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal)
                .frame(height: 28)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.red))
        }
    }
    var saveProfileButton: some View {
        Button {
            viewModel.saveButtonAction()
        } label: {
            let title = viewModel.profileContext == .create ? "Create Profile" : "Update Profile"
            DDGButton(title: title)
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
