
import Foundation

// MARK: - OWMService

struct OWMService {
    let service: DataService
    
     func getForecast(lat: Double, lon: Double) async throws -> OWMForecast {
        let request = OWMEndpoints.forecast(lat, lon).request
        let result = try await service.load(from: request, convertTo: OWMForecast.self)
        return result
    }
    
}
