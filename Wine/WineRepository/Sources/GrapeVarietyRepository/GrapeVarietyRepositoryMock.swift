import Dependencies
import Foundation
import SharedCommonPersistence
import WineEntity

public extension GrapeVarietyRepository {
    static func mock(
        fetchAll: @escaping @MainActor @Sendable (String) async throws -> [GrapeVarietyEntity] = { _ in fatalError("Not mocked yet") },
        upsert: @escaping @MainActor @Sendable (GrapeVarietyEntity) async throws -> GrapeVarietyEntity = { _ in fatalError("Not mocked yet") }
    ) -> GrapeVarietyRepository {
        GrapeVarietyRepository(
            fetchAll: fetchAll,
            upsert: upsert
        )
    }
}
