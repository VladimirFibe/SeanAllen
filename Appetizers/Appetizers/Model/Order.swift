import SwiftUI

final class Order: ObservableObject {
    @Published var items: [Appetizer] = []
    
    var total: Double {
        items.reduce(0) { $0 + $1.price }
    }
    
    var title: LocalizedStringKey {
        "$\(total, specifier: "%.2f") Order"
    }
    
    var isEmpty: Bool {
        items.isEmpty
    }
    
    func add(_ appetizer: Appetizer) {
        items.append(appetizer)
    }
    
    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}
