//
//  ChartView.Model.swift
//  FHNW-Charts
//
//  Created by Ingo Boehme on 09.01.23.
//

import Foundation

extension ChartView {
    enum ModelError: Error {
        case modelError
    }

    struct ModelData {
        let data = Data(capacity: 100)
    }

    class Model: ObservableObject {
        func fetch(lat: Double, lon: Double) async throws -> OWMForecast {
            let forecast = try await OWMService.getForecast(lat: lat, lon: lon)
            return forecast
        }
    }
}
