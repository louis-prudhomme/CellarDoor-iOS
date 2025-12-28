import SwiftData
import Foundation
import SharedCommonPersistence

// Warning: Add every new entity in the schema declaration in SharedCommonModelContainer

@Model
public final class WineEntity: IdentifiableEntity {
    @Attribute(.unique) public var id: UUID
    @Attribute public var name: String
    @Attribute public var createdAt: Date

    public init(id: UUID, name: String, createdAt: Date) {
        self.id = id
        self.name = name
        self.createdAt = createdAt
    }
    
    public static func idPredicate(for id: UUID) -> Predicate<WineEntity> {
        #Predicate<WineEntity> { $0.id == id }
    }
}

public extension WineEntity {
    static func new(id: UUID, name: String, createdAt: Date) -> WineEntity {
        return WineEntity(id: id, name: name, createdAt: createdAt)
    }
    
    func update(from entity: WineEntity) {
        // id is immutable, no update needed
        name = entity.name
        createdAt = entity.createdAt
    }
}
