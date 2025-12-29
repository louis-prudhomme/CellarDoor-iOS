import Dependencies
import Foundation
import WineEntity

public extension WineRepository {
    static func mock(
        fetchAll: @escaping @MainActor @Sendable () async throws -> [WineBottleEntity] = { [] },
        fetch: @escaping @MainActor @Sendable (UUID) async throws -> WineBottleEntity? = { _ in nil },
        upsert: @escaping @MainActor @Sendable (WineBottleEntity) async throws -> Void = { _ in },
        delete: @escaping @MainActor @Sendable (UUID) async throws -> Void = { _ in }
    ) -> WineRepository {
        WineRepository(
            base: .mock(
                fetchAll: fetchAll,
                fetch: fetch,
                upsert: upsert,
                delete: delete
            )
        )
    }
}
