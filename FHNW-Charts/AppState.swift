//
//  AppState.swift
//  FHNW-Charts
//
//  Created by Ingo Boehme on 11.01.23.
//

import Foundation

class AppState: ObservableObject {

    @Published var stage = "Mock"

    var service: DataService {
        switch stage {
        case "production":
            return NetworkService()
        case "test":
            return MockService()
        default:
            return MockService()
        }
    }
}
