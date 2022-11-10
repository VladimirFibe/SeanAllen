//
//  ProfileView.swift
//  Appetizers
//
//  Created by Vladimir Fibe on 05.11.2022.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationView { content }
            
    }
    var content: some View {
        Form {
            Section(header: Text("Personal Info")) {
                TextField("First Name", text: $viewModel.user.firstname)
                TextField("Last Name", text: $viewModel.user.lastname)
                TextField("Email", text: $viewModel.user.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                DatePicker("Birthday", selection: $viewModel.user.birthdate, displayedComponents: .date)
                Button(action: viewModel.saveChanges) {
                    Text("Save changes")
                }
            }
            
            Section(header: Text("Request")) {
                Toggle("Extra Napkins", isOn: $viewModel.user.extraNapkins)
                Toggle("Frequent Refills", isOn: $viewModel.user.frequentRefills)
            }
            .toggleStyle(SwitchToggleStyle(tint: .brandPrimary))
        }
        .navigationTitle("😀 Profile")
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
