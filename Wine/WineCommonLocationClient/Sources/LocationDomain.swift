import Foundation
import SharedCommonDependencies

// MARK: - Domain Models

public struct Location: Identifiable, ClientSuccess {
    public let id: Int
    public let name: String
    public let coordinates: GeographicalCoordinates
    public let administrativeDivisions: [AdministrativeDivision]
    public let population: Int?
    public let elevation: Int?
}

public extension Location {
    struct GeographicalCoordinates: ClientSuccess {
        public let latitude: Double
        public let longitude: Double
    }
}

public extension Location {
    struct AdministrativeDivision: ClientSuccess {
        public let type: `Type`
        public let name: String
        public let code: String

        public enum `Type`: ClientSuccess {
            case country
            case region
            case countyOrSmaller

            var importance: Int {
                switch self {
                case .country: 1
                case .region: 2
                case .countyOrSmaller: 3
                }
            }
        }
    }
}

// MARK: - Adapter

public extension Location {
    init(from dto: GeoNameDTO) {
        id = dto.geonameId
        name = dto.name
        coordinates = GeographicalCoordinates(
            latitude: Double(dto.lat) ?? 0.0,
            longitude: Double(dto.lng) ?? 0.0
        )

        var includedIn = [AdministrativeDivision]()
        if let countryName = dto.countryName, let countryCode = dto.countryCode {
            includedIn.append(AdministrativeDivision(type: .country, name: countryName, code: countryCode))
        }
        if let adminName1 = dto.adminName1, let adminCode1 = dto.adminCode1 {
            includedIn.append(AdministrativeDivision(type: .region, name: adminName1, code: adminCode1))
        }
        if let adminName2 = dto.adminName2, let adminCode2 = dto.adminCode2 {
            includedIn.append(AdministrativeDivision(type: .countyOrSmaller, name: adminName2, code: adminCode2))
        }
        if let adminName3 = dto.adminName3, let adminCode3 = dto.adminCode3 {
            includedIn.append(AdministrativeDivision(type: .countyOrSmaller, name: adminName3, code: adminCode3))
        }
        if let adminName4 = dto.adminName4, let adminCode4 = dto.adminCode4 {
            includedIn.append(AdministrativeDivision(type: .countyOrSmaller, name: adminName4, code: adminCode4))
        }
        if let adminName5 = dto.adminName5, let adminCode5 = dto.adminCode5 {
            includedIn.append(AdministrativeDivision(type: .countyOrSmaller, name: adminName5, code: adminCode5))
        }
        administrativeDivisions = includedIn.sorted { $0.type.importance < $1.type.importance }

        population = dto.population
        elevation = dto.elevation
    }
}
