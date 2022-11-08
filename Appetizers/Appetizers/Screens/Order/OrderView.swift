//
//  OrderView.swift
//  Appetizers
//
//  Created by Vladimir Fibe on 05.11.2022.
//

import SwiftUI

struct OrderView: View {
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                content
            }
        } else {
            NavigationView {
                content
            }
        }
    }
    var content: some View {
        VStack {
            Text("Order")
        }
        .navigationTitle("😀 Order")
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}
