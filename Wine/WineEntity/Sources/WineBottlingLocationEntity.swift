import Foundation
import SharedCommonPersistence
import SwiftData

// Warning: Add every new entity in the schema declaration in SharedCommonModelContainer

@Model
public final class WineBottlingLocationEntity: IdentifiableEntity {
    @Attribute(.unique) public var id: UUID
    @Attribute public var name: String
    @Attribute public var latitude: Double
    @Attribute public var longitude: Double
    @Attribute public var countryCode: String
    @Attribute public var regionCode: String?
    @Attribute public var administrativeDivisions: Data // JSON encoded array of AdministrativeDivision
    @Attribute public var providerId: Int // GeoNames ID
    @Attribute public var createdAt: Date

    @Relationship(deleteRule: .cascade, inverse: \WineBottleEntity.bottlingLocation) public var wines: [WineBottleEntity]?

    public init(
        id: UUID,
        name: String,
        latitude: Double,
        longitude: Double,
        countryCode: String,
        regionCode: String?,
        administrativeDivisions: Data,
        providerId: Int,
        createdAt: Date
    ) {
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.countryCode = countryCode
        self.regionCode = regionCode
        self.administrativeDivisions = administrativeDivisions
        self.providerId = providerId
        self.createdAt = createdAt
    }

    public static func idPredicate(for id: UUID) -> Predicate<WineBottlingLocationEntity> {
        #Predicate<WineBottlingLocationEntity> { $0.id == id }
    }
}

public extension WineBottlingLocationEntity {
    func update(from entity: WineBottlingLocationEntity) {
        // id is immutable, no update needed
        name = entity.name
        latitude = entity.latitude
        longitude = entity.longitude
        countryCode = entity.countryCode
        regionCode = entity.regionCode
        administrativeDivisions = entity.administrativeDivisions
        providerId = entity.providerId
        createdAt = entity.createdAt
    }
}
