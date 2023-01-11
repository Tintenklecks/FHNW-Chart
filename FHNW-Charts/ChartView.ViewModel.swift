//
//  ChartView.ViewModel.swift
//  FHNW-Charts
//
//  Created by Ingo Boehme on 09.01.23.
//

import Foundation

// MARK: - Temperature

struct Temperature: Identifiable {
    let id = UUID()
    let date: Date
    let temperature: Double
}

extension ChartView {
    class ViewModel: ObservableObject {
        @Published var city: String = ""
        @Published var temperature: [Temperature] = []
        @Published var errorText: String?



        var service: DataService?

        func reload(latitudeDegree: Int, latitudeFragment: Int, longitudeDegree: Int, longitudeFragment: Int) {
            reload(latitude: Double(latitudeDegree) + Double(latitudeFragment) / 100,
                   longitude: Double(longitudeDegree) + Double(longitudeFragment) / 100)
        }

        func reload(latitude: Double, longitude: Double) {
            Task {
                do {
                    guard let service = self.service else {
                        throw NetworkError.misc("Service not specified")
                    }
                    let model = Model(service: service)

                    let forecast = try await model.fetch(lat: latitude, lon: longitude)
                    DispatchQueue.main.async {
                        self.temperature = []
                        self.city = "\(forecast.city.name) (\(forecast.city.country))"
                        for entry in forecast.list {
                            let date = Date(timeIntervalSince1970: Double(entry.dt))
                            let degree = entry.main.temp
                            self.temperature.append(Temperature(date: date, temperature: degree))
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        if let error = error as? NetworkError {
                            self.errorText = error.errDescription
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                        self.errorText = nil
                    }
                }
            }
        }
    }
}
