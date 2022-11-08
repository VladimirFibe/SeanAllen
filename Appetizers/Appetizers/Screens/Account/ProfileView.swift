//
//  ProfileView.swift
//  Appetizers
//
//  Created by Vladimir Fibe on 05.11.2022.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                VStack {
                    Text("Profile")
                }
                .navigationTitle("😀 Profile")
            }
        } else {
            NavigationView {
                VStack {
                    Text("Profile")
                }
                .navigationTitle("😀 Profile")
            }
        }
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
