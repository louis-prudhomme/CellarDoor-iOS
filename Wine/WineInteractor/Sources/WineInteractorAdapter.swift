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
            picture: picture,
            bottlingLocation: decodedLocation,
            grapeVarieties: grapeVarieties.map { $0.toDomain() },
            winemaker: winemaker?.toDomain(),
            appellation: try appellation.toDomain(),
            createdAt: createdAt
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
            picture: picture,
            bottlingLocation: encodedLocation,
            grapeVarieties: grapeVarieties.map { $0.toEntity() },
            createdAt: createdAt,
            winemaker: winemaker?.toEntity(),
            appellation: try appellation.toEntity()
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
            default:
                if rawValue.starts(with: "countyOrSmaller_"),
                   let importanceString = rawValue.split(separator: "_").last,
                   let importance = Int(importanceString)
                {
                    self = .countyOrSmaller(importance)
                } else {
                    throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid DivisionType value: \(rawValue)")
                }
        }
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        let rawValue = switch self {
            case .country: "country"
            case .region: "region"
            case let .countyOrSmaller(importance): "countyOrSmaller_\(importance)"
        }
        try container.encode(rawValue)
    }
}

// MARK: - Appellation, Region, Vineyard conversions

public extension AppellationEntity {
    func toDomain() throws -> Appellation {
        try Appellation(
            id: id,
            name: name,
            region: region.toDomain(),
            createdAt: createdAt
        )
    }
}

public extension Appellation {
    func toEntity() throws -> AppellationEntity {
        try AppellationEntity(
            id: id,
            name: name,
            region: region.toEntity(),
            createdAt: createdAt
        )
    }
}

public extension RegionEntity {
    func toDomain() throws -> Region {
        try Region(
            id: id,
            name: name,
            vineyard: vineyard.toDomain(),
            createdAt: createdAt
        )
    }
}

public extension Region {
    func toEntity() throws -> RegionEntity {
        try RegionEntity(
            id: id,
            name: name,
            vineyard: vineyard.toEntity(),
            createdAt: createdAt
        )
    }
}

public extension VineyardEntity {
    func toDomain() throws -> Vineyard {
        Vineyard(
            id: id,
            name: name,
            country: country.toDomain(),
            createdAt: createdAt
        )
    }
}

public extension Vineyard {
    func toEntity() throws -> VineyardEntity {
        VineyardEntity(
            id: id,
            name: name,
            country: country.toEntity(),
            createdAt: createdAt
        )
    }
}

public extension CountryEntity {
    func toDomain() -> Country {
        Country(
            id: id,
            name: name,
            code: code,
            createdAt: createdAt
        )
    }
}

public extension Country {
    func toEntity() -> CountryEntity {
        CountryEntity(
            id: id,
            name: name,
            code: code,
            createdAt: createdAt
        )
    }
}
