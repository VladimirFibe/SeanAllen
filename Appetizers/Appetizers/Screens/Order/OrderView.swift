//
//  OrderView.swift
//  Appetizers
//
//  Created by Vladimir Fibe on 05.11.2022.
//

import SwiftUI

struct OrderView: View {
    @EnvironmentObject var order: Order
    var body: some View {
        NavigationView {
            VStack {
                if order.items.isEmpty {
                    EmptyState(message: "You have no items in your order. Please add an appetizer!")
                } else {
                    List {
                        ForEach(order.items) { appetizer in
                            AppetizerView(appetizer: appetizer)
                        }
                        .onDelete(perform: order.delete)
                    }
                    .listStyle(PlainListStyle())
                    
                    BrandButton(title: order.title) {
                        print("order")
                    }
                    .padding(.bottom, 25)
                }
            }
            .navigationTitle("😀 Order")
        }
    }
    
    
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
            .environmentObject(Order())
    }
}
