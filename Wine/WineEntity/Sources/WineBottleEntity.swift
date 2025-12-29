import SwiftData
import Foundation
import SharedCommonPersistence

// Warning: Add every new entity in the schema declaration in SharedCommonModelContainer

@Model
public final class WineBottleEntity: IdentifiableEntity {
    @Attribute(.unique) public var id: UUID
    @Attribute public var name: String
    @Attribute public var millesime: Int
    @Attribute public var createdAt: Date
    
    @Relationship(deleteRule: .nullify)
    public var winemaker: WinemakerEntity?

    public init(id: UUID, name: String, millesime: Int, createdAt: Date, winemaker: WinemakerEntity? = nil) {
        self.id = id
        self.name = name
        self.millesime = millesime
        self.createdAt = createdAt
        self.winemaker = winemaker
    }
    
    public static func idPredicate(for id: UUID) -> Predicate<WineBottleEntity> {
        #Predicate<WineBottleEntity> { $0.id == id }
    }
}

public extension WineBottleEntity {
    static func new(id: UUID, name: String, millesime: Int, createdAt: Date, winemaker: WinemakerEntity? = nil) -> WineBottleEntity {
        return WineBottleEntity(id: id, name: name, millesime: millesime, createdAt: createdAt, winemaker: winemaker)
    }
    
    func update(from entity: WineBottleEntity) {
        // id is immutable, no update needed
        name = entity.name
        millesime = entity.millesime
        createdAt = entity.createdAt
        winemaker = entity.winemaker
    }
}
