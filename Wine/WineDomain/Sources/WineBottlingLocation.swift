import Dependencies
import Foundation
import SharedCommonDomain

public struct WineBottlingLocation: Interactable {
    public let id: UUID
    public let name: String
    public let coordinates: GeographicalCoordinates
    public let administrativeDivisions: [AdministrativeDivision]
    public let providerId: Int
    public let createdAt: Date

    public init(
        id: UUID,
        name: String,
        coordinates: GeographicalCoordinates,
        administrativeDivisions: [AdministrativeDivision],
        providerId: Int,
        createdAt: Date
    ) {
        self.id = id
        self.name = name
        self.coordinates = coordinates
        self.administrativeDivisions = administrativeDivisions
        self.providerId = providerId
        self.createdAt = createdAt
    }
}

public extension WineBottlingLocation {
    var countryCode: String? {
        administrativeDivisions.first { $0.type == .country }?.code
    }

    var regionCode: String? {
        administrativeDivisions.first { $0.type == .region }?.code
    }
}

public extension WineBottlingLocation {
    struct GeographicalCoordinates: Equatable, Sendable {
        public let latitude: Double
        public let longitude: Double

        public init(latitude: Double, longitude: Double) {
            self.latitude = latitude
            self.longitude = longitude
        }
    }
}

public extension WineBottlingLocation {
    struct AdministrativeDivision: Equatable, Sendable {
        public let type: DivisionType
        public let name: String
        public let code: String

        public init(type: DivisionType, name: String, code: String) {
            self.type = type
            self.name = name
            self.code = code
        }

        public enum DivisionType: Equatable, Sendable {
            case country
            case region
            case countyOrSmaller

            public var importance: Int {
                switch self {
                case .country: 1
                case .region: 2
                case .countyOrSmaller: 3
                }
            }
        }
    }
}

public extension WineBottlingLocation {
    init(
        name: String,
        coordinates: GeographicalCoordinates,
        administrativeDivisions: [AdministrativeDivision],
        providerId: Int
    ) {
        @Dependency(\.uuid) var uuid
        @Dependency(\.date) var date

        self.init(
            id: uuid(),
            name: name,
            coordinates: coordinates,
            administrativeDivisions: administrativeDivisions,
            providerId: providerId,
            createdAt: date()
        )
    }
}
