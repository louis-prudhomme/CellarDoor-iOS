import SwiftData
import Foundation
import SharedCommonPersistence

// Warning: Add every new entity in the schema declaration in SharedCommonModelContainer

@Model
public final class WinemakerEntity: IdentifiableEntity {
    @Attribute(.unique) public var id: UUID
    @Attribute public var name: String
    @Attribute public var createdAt: Date
    
    @Relationship(deleteRule: .nullify, inverse: \WineBottleEntity.winemaker)
    public var wines: [WineBottleEntity]?

    public init(id: UUID, name: String, createdAt: Date) {
        self.id = id
        self.name = name
        self.createdAt = createdAt
    }
    
    public static func idPredicate(for id: UUID) -> Predicate<WinemakerEntity> {
        #Predicate<WinemakerEntity> { $0.id == id }
    }
}

public extension WinemakerEntity {
    static func new(id: UUID, name: String, createdAt: Date) -> WinemakerEntity {
        return WinemakerEntity(id: id, name: name, createdAt: createdAt)
    }
    
    func update(from entity: WinemakerEntity) {
        // id is immutable, no update needed
        name = entity.name
        createdAt = entity.createdAt
    }
}
