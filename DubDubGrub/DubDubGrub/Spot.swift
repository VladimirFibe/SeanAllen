import Foundation

struct Spot: Identifiable {
    let id = UUID()
    let name: String
    let count = Int.random(in: 0...20)
    static let all = [
        Spot(name: "AC Kitchen & Lounge"),
        Spot(name: "Chipotle"),
        Spot(name:  "Crace Del & Cafe")
    ]
}
