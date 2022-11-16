//
//  LocationManager.swift
//  DubDubGrub
//
//  Created by Vladimir Fibe on 16.11.2022.
//

import Foundation

final class LocationManager: ObservableObject {
    @Published var locations: [DDGLocation] = []
}
