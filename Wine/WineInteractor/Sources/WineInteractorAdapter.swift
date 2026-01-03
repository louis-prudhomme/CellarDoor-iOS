import CodableDependency
import Foundation
import SharedCommonDependencies
import WineDomain
import WineRepository

// MARK: - Entity → Domain

public extension WineBottleEntity {
    func toDomain() throws -> WineBottle {
        guard let decodedLocation = try? bottlingLocation.toDomain() else {
            throw WineInteractorError.badData
        }

        return WineBottle(
            id: id,
            name: name,
            millesime: millesime,
            abv: abv,
            bottlingLocation: decodedLocation,
            grapeVarieties: grapeVarieties.map { $0.toDomain() },
            createdAt: createdAt,
            winemaker: winemaker?.toDomain()
        )
    }
}

public extension GrapeVarietyEntity {
    func toDomain() -> GrapeVariety {
        GrapeVariety(
            id: id,
            name: name,
            createdAt: createdAt
        )
    }
}

public extension WinemakerEntity {
    func toDomain() -> Winemaker {
        Winemaker(
            id: id,
            name: name,
            createdAt: createdAt
        )
    }
}

public extension WineBottlingLocationEntity {
    func toDomain() throws -> WineBottlingLocation {
        @Dependency(\.decode) var decode

        guard let divisions = try? decode([WineBottlingLocation.AdministrativeDivision].self, from: administrativeDivisions) else {
            throw WineInteractorError.badData
        }

        return WineBottlingLocation(
            id: id,
            name: name,
            coordinates: WineBottlingLocation.GeographicalCoordinates(latitude: latitude, longitude: longitude),
            administrativeDivisions: divisions,
            providerId: providerId,
            createdAt: createdAt
        )
    }
}

// MARK: - Domain → Entity

public extension WineBottle {
    func toEntity() throws -> WineBottleEntity {
        guard let encodedLocation = try? bottlingLocation.toEntity() else {
            throw WineInteractorError.badData
        }

        return WineBottleEntity(
            id: id,
            name: name,
            millesime: millesime,
            abv: abv,
            bottlingLocation: encodedLocation,
            grapeVarieties: grapeVarieties.map { $0.toEntity() },
            createdAt: createdAt,
            winemaker: winemaker?.toEntity()
        )
    }
}

public extension Winemaker {
    func toEntity() -> WinemakerEntity {
        WinemakerEntity(
            id: id,
            name: name,
            createdAt: createdAt
        )
    }
}

public extension GrapeVariety {
    func toEntity() -> GrapeVarietyEntity {
        GrapeVarietyEntity(
            id: id,
            name: name,
            createdAt: createdAt
        )
    }
}

public extension WineBottlingLocation {
    func toEntity() throws -> WineBottlingLocationEntity {
        @Dependency(\.encode) var encode

        guard let encodedDivisions = try? encode(administrativeDivisions) else {
            throw WineInteractorError.badData
        }

        return WineBottlingLocationEntity(
            id: id,
            name: name,
            latitude: coordinates.latitude,
            longitude: coordinates.longitude,
            countryCode: countryCode ?? "",
            regionCode: regionCode,
            administrativeDivisions: encodedDivisions,
            providerId: providerId,
            createdAt: createdAt
        )
    }
}

// MARK: - Codable conformances

extension WineBottlingLocation.AdministrativeDivision: @retroactive Codable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(DivisionType.self, forKey: .type)
        let name = try container.decode(String.self, forKey: .name)
        let code = try container.decode(String.self, forKey: .code)
        self.init(type: type, name: name, code: code)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(name, forKey: .name)
        try container.encode(code, forKey: .code)
    }

    enum CodingKeys: CodingKey {
        case type
        case name
        case code
    }
}

extension WineBottlingLocation.AdministrativeDivision.DivisionType: @retroactive Codable {
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        switch rawValue {
            case "country": self = .country
            case "region": self = .region
            case "countyOrSmaller": self = .countyOrSmaller
            default: throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid DivisionType value")
        }
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        let rawValue = switch self {
            case .country: "country"
            case .region: "region"
            case .countyOrSmaller: "countyOrSmaller"
        }
        try container.encode(rawValue)
    }
}
