//
//  OrderView.swift
//  Appetizers
//
//  Created by Vladimir Fibe on 05.11.2022.
//

import SwiftUI

struct OrderView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Order")
            }
            .navigationTitle("😀 Order")
        }
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}
