import Foundation
import WineDomain
import WineRepository

// MARK: - Entity → Domain

public extension WineBottleEntity {
    func toDomain() -> WineBottle {
        WineBottle(
            id: id,
            name: name,
            createdAt: createdAt
        )
    }
}

// MARK: - Domain → Entity

public extension WineBottle {
    /// Creates a new Entity instance from this Domain model.
    func toEntity() -> WineBottleEntity {
        WineBottleEntity(
            id: id,
            name: name,
            createdAt: createdAt
        )
    }
}
