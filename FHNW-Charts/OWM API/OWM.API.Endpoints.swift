import Foundation

// MARK: - OWMAPI

enum OWMEndpoints {
    case forecast(Double, Double)

    var url: URL {
        switch self {
        case .forecast:
            return URL(string: "https://api.openweathermap.org/data/2.5/forecast")!
        }
    }

    var httpMethod: String {
        switch self {
        default: return "GET"
        }
    }

    var request: URLRequest {
        var parameter = ["appid": Secret.apiKey]
        parameter["units"] = "metric"
        
        // depending on the request endpoint
        switch self {
        case .forecast(let latitude, let longitude):
            parameter["lat"] = "\(latitude)"
            parameter["lon"] = "\(longitude)"
        }

        let queryItems = parameter
            .compactMap { URLQueryItem(name: $0, value: $1) }
        var url = self.url
        url.append(queryItems: queryItems)

        var localRequest = URLRequest(url: url)
        localRequest.httpMethod = self.httpMethod
        localRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

//        switch self {
//        case .forecast(_, _):
//            let body = ... some encodable data object
//            localRequest.httpBody = try? JSONEncoder().encode(body)
//        }

        return localRequest

    }
}
