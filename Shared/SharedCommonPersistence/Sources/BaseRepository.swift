import SwiftData
import Foundation
import Dependencies

// MARK: - Identifiable Entity Protocol

/// Entities must conform to this for use with BaseRepository.
public protocol IdentifiableEntity: PersistentModel {
    var id: UUID { get }

    /// Updates this entity's properties from another entity of the same type.
    func update(from entity: Self)

    /// Returns a predicate matching this entity type by ID.
    static func idPredicate(for id: UUID) -> Predicate<Self>
}

// MARK: - Base Repository

public struct BaseRepository<TEntity: IdentifiableEntity>: Sendable {
    public var fetchAll: @MainActor @Sendable () async throws -> [TEntity]
    public var fetch: @MainActor @Sendable (UUID) async throws -> TEntity?
    public var upsert: @MainActor @Sendable (TEntity) async throws -> Void
    public var delete: @MainActor @Sendable (UUID) async throws -> Void

    public init(
        fetchAll: @escaping @MainActor @Sendable () async throws -> [TEntity],
        fetch: @escaping @MainActor @Sendable (UUID) async throws -> TEntity?,
        upsert: @escaping @MainActor @Sendable (TEntity) async throws -> Void,
        delete: @escaping @MainActor @Sendable (UUID) async throws -> Void
    ) {
        self.fetchAll = fetchAll
        self.fetch = fetch
        self.upsert = upsert
        self.delete = delete
    }
}

// MARK: - Live Implementation

public extension BaseRepository {
    static func live() -> BaseRepository<TEntity> {
        BaseRepository(
            fetchAll: { @MainActor in
                @Dependency(\.modelContainer) var container
                let context = container.mainContext
                let descriptor = FetchDescriptor<TEntity>()
                return try context.fetch(descriptor)
            },
            fetch: { @MainActor id in
                @Dependency(\.modelContainer) var container
                let context = container.mainContext
                let predicate = TEntity.idPredicate(for: id)
                let descriptor = FetchDescriptor<TEntity>(predicate: predicate)
                return try context.fetch(descriptor).first
            },
            upsert: { @MainActor entity in
                @Dependency(\.modelContainer) var container
                let context = container.mainContext
                let predicate = TEntity.idPredicate(for: entity.id)
                let descriptor = FetchDescriptor<TEntity>(predicate: predicate)
                if let existing = try context.fetch(descriptor).first {
                    existing.update(from: entity)
                } else {
                    context.insert(entity)
                }
                try context.save()
            },
            delete: { @MainActor id in
                @Dependency(\.modelContainer) var container
                let context = container.mainContext
                let predicate = TEntity.idPredicate(for: id)
                let descriptor = FetchDescriptor<TEntity>(predicate: predicate)
                if let entity = try context.fetch(descriptor).first {
                    context.delete(entity)
                    try context.save()
                }
            }
        )
    }
}

// MARK: - Mock Implementation

public extension BaseRepository {
    static func mock() -> BaseRepository<TEntity> {
        BaseRepository(
            fetchAll: { @MainActor in
                @Dependency(\.modelContainer) var container
                let context = container.mainContext
                let descriptor = FetchDescriptor<TEntity>()
                return try context.fetch(descriptor)
            },
            fetch: { @MainActor id in
                @Dependency(\.modelContainer) var container
                let context = container.mainContext
                let predicate = TEntity.idPredicate(for: id)
                let descriptor = FetchDescriptor<TEntity>(predicate: predicate)
                return try context.fetch(descriptor).first
            },
            upsert: { @MainActor entity in
                @Dependency(\.modelContainer) var container
                let context = container.mainContext
                let predicate = TEntity.idPredicate(for: entity.id)
                let descriptor = FetchDescriptor<TEntity>(predicate: predicate)
                if let existing = try context.fetch(descriptor).first {
                    existing.update(from: entity)
                } else {
                    context.insert(entity)
                }
                try context.save()
            },
            delete: { @MainActor id in
                @Dependency(\.modelContainer) var container
                let context = container.mainContext
                let predicate = TEntity.idPredicate(for: id)
                let descriptor = FetchDescriptor<TEntity>(predicate: predicate)
                if let entity = try context.fetch(descriptor).first {
                    context.delete(entity)
                    try context.save()
                }
            }
        )
    }
}
