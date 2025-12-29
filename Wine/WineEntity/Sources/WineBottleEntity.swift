import SwiftData
import Foundation
import SharedCommonPersistence

// Warning: Add every new entity in the schema declaration in SharedCommonModelContainer

@Model
public final class WineBottleEntity: IdentifiableEntity {
    @Attribute(.unique) public var id: UUID
    @Attribute public var name: String
    @Attribute public var createdAt: Date

    public init(id: UUID, name: String, createdAt: Date) {
        self.id = id
        self.name = name
        self.createdAt = createdAt
    }
    
    public static func idPredicate(for id: UUID) -> Predicate<WineBottleEntity> {
        #Predicate<WineBottleEntity> { $0.id == id }
    }
}

public extension WineBottleEntity {
    static func new(id: UUID, name: String, createdAt: Date) -> WineBottleEntity {
        return WineBottleEntity(id: id, name: name, createdAt: createdAt)
    }
    
    func update(from entity: WineBottleEntity) {
        // id is immutable, no update needed
        name = entity.name
        createdAt = entity.createdAt
    }
}
