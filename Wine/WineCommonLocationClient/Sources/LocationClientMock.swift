import Foundation
import SharedCommonDependencies

extension LocationClient {
    static let mock = LocationClient(
        search: { _ in
            fatalError("LocationClient.search")
        }
    )
}

// MARK: - Mock Data for Testing

public extension LocationClient {
    static let mockWithData = LocationClient(
        search: { name in
            let queryParams = GeoNamesQueryParameters.defaultWith(name: name)

            return .success([
                Location(
                    id: 2_988_507,
                    name: queryParams.placename,
                    coordinates: .init(
                        latitude: 48.85341,
                        longitude: 2.3488
                    ),
                    administrativeDivisions: [
                        .init(type: .country, name: "France", code: "FR"),
                        .init(type: .region, name: "Île-de-France", code: "11")
                    ],
                    population: 2_138_551,
                    elevation: nil
                )
            ])
        }
    )

    static let mockWithError = LocationClient(
        search: { _ in
            return .failure(.noResultsFound)
        }
    )
}
