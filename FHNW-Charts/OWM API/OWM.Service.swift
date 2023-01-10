
import Foundation

// MARK: - OWMService

class OWMService {
    static func getForecast(lat: Double, lon: Double) async throws -> OWMForecast {
        let request = OWMEndpoints.forecast(lat, lon).request
        let result = try await NetworkService.load(from: request, convertTo: OWMForecast.self)
        return result
    }
    
}
