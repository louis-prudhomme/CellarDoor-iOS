import Foundation
import SharedCommonPersistence
import SwiftData

// Warning: Add every new entity in the schema declaration in SharedCommonModelContainer

@Model
public final class RegionEntity: IdentifiableEntity {
    @Attribute(.unique) public var id: UUID
    @Attribute public var name: String
    @Attribute public var createdAt: Date

    @Relationship(deleteRule: .nullify) public var vineyard: VineyardEntity
    @Relationship(deleteRule: .nullify, inverse: \AppellationEntity.region) public var appellations: [AppellationEntity]?

    public init(id: UUID, name: String, vineyard: VineyardEntity, createdAt: Date) {
        self.id = id
        self.name = name
        self.vineyard = vineyard
        self.createdAt = createdAt
    }

    public static func idPredicate(for id: UUID) -> Predicate<RegionEntity> {
        #Predicate<RegionEntity> { $0.id == id }
    }
}

public extension RegionEntity {
    func update(from entity: RegionEntity) {
        // id is immutable, no update needed
        name = entity.name
        vineyard = entity.vineyard
        createdAt = entity.createdAt
    }
}
