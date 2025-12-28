import Dependencies
import Foundation
import WineEntity

public extension WineRepository {
    static func mock(
        fetchAll: @escaping @MainActor @Sendable () async throws -> [WineEntity] = { [] },
        fetch: @escaping @MainActor @Sendable (UUID) async throws -> WineEntity? = { _ in nil },
        upsert: @escaping @MainActor @Sendable (WineEntity) async throws -> Void = { _ in },
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
