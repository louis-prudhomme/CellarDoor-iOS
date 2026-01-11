import Foundation
import SharedCommonPersistence
import SwiftData

// Warning: Add every new entity in the schema declaration in SharedCommonModelContainer

@Model
public final class AppellationEntity: IdentifiableEntity {
    @Attribute(.unique) public var id: UUID
    @Attribute public var name: String
    @Attribute public var createdAt: Date

    @Relationship(deleteRule: .nullify) public var region: RegionEntity
    @Relationship(deleteRule: .nullify, inverse: \WineBottleEntity.appellation) public var wines: [WineBottleEntity]?

    public init(id: UUID, name: String, region: RegionEntity, createdAt: Date) {
        self.id = id
        self.name = name
        self.region = region
        self.createdAt = createdAt
    }

    public static func idPredicate(for id: UUID) -> Predicate<AppellationEntity> {
        #Predicate<AppellationEntity> { $0.id == id }
    }
}

public extension AppellationEntity {
    func update(from entity: AppellationEntity) {
        // id is immutable, no update needed
        name = entity.name
        region = entity.region
        createdAt = entity.createdAt
    }
}
