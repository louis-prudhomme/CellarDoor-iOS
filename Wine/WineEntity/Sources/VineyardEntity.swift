import Foundation
import SharedCommonPersistence
import SwiftData

// Warning: Add every new entity in the schema declaration in SharedCommonModelContainer

@Model
public final class VineyardEntity: IdentifiableEntity {
    @Attribute(.unique) public var id: UUID
    @Attribute public var name: String
    @Attribute public var createdAt: Date

    @Relationship(deleteRule: .nullify) public var country: CountryEntity
    @Relationship(deleteRule: .nullify, inverse: \RegionEntity.vineyard) public var regions: [RegionEntity]?

    public init(id: UUID, name: String, country: CountryEntity, createdAt: Date) {
        self.id = id
        self.name = name
        self.country = country
        self.createdAt = createdAt
    }

    public static func idPredicate(for id: UUID) -> Predicate<VineyardEntity> {
        #Predicate<VineyardEntity> { $0.id == id }
    }
}

public extension VineyardEntity {
    func update(from entity: VineyardEntity) {
        // id is immutable, no update needed
        name = entity.name
        country = entity.country
        createdAt = entity.createdAt
    }
}
