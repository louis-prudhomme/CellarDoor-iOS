import Foundation
import WineDomain
import WineRepository

// MARK: - Entity → Domain

public extension WineEntity {
    func toDomain() -> Wine {
        Wine(
            id: id,
            name: name,
            createdAt: createdAt
        )
    }
}

// MARK: - Domain → Entity

public extension Wine {
    /// Creates a new Entity instance from this Domain model.
    func toEntity() -> WineEntity {
        WineEntity(
            id: id,
            name: name,
            createdAt: createdAt
        )
    }
}
