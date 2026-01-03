import Foundation
import SharedCommonDependencies
import URLQueryItemCoder

extension LocationClient {
    static let live = LocationClient(
        search: { name in
            let queryParams = GeoNamesQueryParameters.defaultWith(name: name)

            return await performGeoNamesRequest(
                queryParameters: queryParams
            ) { data in
                let result = try JSONDecoder().decode(GeoNamesSearchDTO.self, from: data)
                if let status = result.status {
                    throw LocationClientError(from: status)
                }

                guard let geonames = result.geonames else {
                    throw LocationClientError.noData
                }

                return geonames.map(Location.init(from:))
            }
        }
    )
}

// MARK: - API Configuration

private let geoNamesBaseURL = "https://secure.geonames.org/searchJSON"
private let maxNumberOfResults: Int = 1000
private let username = "LouisPH2" // TODO: extract to config

// MARK: - Response Models

private struct GeoNamesStatus: Codable {
    let message: String
    let value: Int
}

private extension GeoNamesSearchDTO {
    struct Response: Codable {
        let geonames: [GeoNameDTO]
        let totalResultsCount: Int
    }
}

// MARK: - Network Helper

private func performGeoNamesRequest<T>(
    queryParameters: GeoNamesQueryParameters,
    decoder: @escaping (Data) throws -> T
) async -> Result<T, LocationClientError> {
    guard var urlComponents = URLComponents(string: geoNamesBaseURL) else {
        return .failure(.invalidURL)
    }

    let encoder = URLQueryItemEncoder(dateStrategy: .secondsSince1970)
    guard var queryItems = try? encoder.encode(queryParameters) else {
        return .failure(.encodingError)
    }
    queryItems.append(URLQueryItem(name: "username", value: username))

    urlComponents.queryItems = queryItems

    guard let url = urlComponents.url else {
        return .failure(.invalidURL)
    }

    @Dependency(\.urlSession) var urlSession
    do {
        let (data, response) = try await urlSession.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            return .failure(.networkError)
        }
        guard 200 ... 299 ~= httpResponse.statusCode else {
            return .failure(.networkError)
        }

        let result = try decoder(data)
        return .success(result)

    } catch is DecodingError {
        return .failure(.decodingError)
    } catch {
        return .failure(.networkError)
    }
}
